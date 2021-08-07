ControlledCharacters = {
    CharacterGenerator = {},
    CachedData = {
        FactionKey = "",
        ExistingGenerals = {},
    },
};

function ControlledCharacters:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function ControlledCharacters:Initialise(core, enableLogging)
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns-ControlledCharacters.txt", enableLogging);
    self.Logger:Log_Start();
    self:SetupListeners(core);
    -- Setup character generator
    self.CharacterGenerator = CharacterGenerator:new({});
    self.CharacterGenerator:Initialise(enableLogging);
end


function ControlledCharacters:SetupNewGameOptions()
    local faction_list = cm:model():world():faction_list();
    for i = 0, faction_list:num_items() - 1 do
        local faction = faction_list:item_at(i);
        if self:IsExcludedFaction(faction) == false
            and IsSupportedSubCulture(faction:subculture()) then
            local factionPoolResources = GetFactionPoolResources(faction);
            if factionPoolResources.LordsToReplace ~= nil then
                self.Logger:Log("Starting check for replacing initial lords for: "..faction:name());
                local character_list = faction:character_list();
                for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i);
                    local charSubType = character:character_subtype_key();
                    if cm:char_is_mobile_general_with_army(character) then
                        if factionPoolResources.LordsToReplace[charSubType] ~= nil then
                            local replaceType = factionPoolResources.LordsToReplace[charSubType].replacementKey;
                            self.Logger:Log("Replacing character: "..charSubType.." with subtype: "..replaceType);
                            cm:callback(function()
                                self:ReplaceCharacter(character, replaceType);
                            end, 0.2);
                        elseif factionPoolResources.LordsToReplace.FactionLeader ~= nil
                        and character:cqi() == faction:faction_leader():cqi() then
                            self.Logger:Log("Replacing faction leader: "..charSubType.." with: "..factionPoolResources.LordsToReplace.FactionLeader);
                            cm:callback(function()
                                self:ReplaceCharacter(character, factionPoolResources.LordsToReplace.FactionLeader);
                            end, 0.2);
                        end
                    end
                end
                self.Logger:Log_Finished();
            end
        end
    end
    self.Logger:Log("Finished new game options.");
end

function ControlledCharacters:SetupListeners(core)
    core:add_listener(
        "MC_CC_FactionTurnEndHuman",
        "FactionTurnEnd",
        function(context)
            return context:faction():is_human() == true;
        end,
        function(context)
            self.Logger:Log_Start();
        end,
        true
    );

    if cm:is_new_game() then
        self.Logger:Log("Setting up new game listener");
        core:add_listener(
            "MC_CC_FactionTurnStart",
            "FactionTurnStart",
            function(context)
                return cm:turn_number() == 1
                and context:faction():is_human() == true;
            end,
            function(context)
                self.Logger:Log("Setting up new game options...");
                self:SetupNewGameOptions();
                self.Logger:Log_Finished();
            end,
            false
        );
    end

    core:add_listener(
        "MC_CC_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            return true;
        end,
        function(context)
            local faction = context:faction();
            local factionKey = faction:name();
            self.CachedData = {
                FactionKey = factionKey,
                ExistingGenerals = {},
            };
            --self.Logger:Log("Rebuilding cache for faction: "..faction:name());
            local character_list = faction:character_list();
            for i = 0, character_list:num_items() - 1 do
                local character = character_list:item_at(i);
                if not character:is_null_interface()
                and character:character_type("general") then
                    --[[self.Logger:Log("Found character: "..character:character_subtype_key());
                    if cm:char_is_mobile_general_with_army(character) then
                        self.Logger:Log("Character has army");
                    else
                        self.Logger:Log("Character does not have army");
                    end
                    if character:is_wounded() then
                        self.Logger:Log("Character is wounded");
                    else
                        self.Logger:Log("Character is not wounded");
                    end--]]
                    self.CachedData.ExistingGenerals[tostring(character:command_queue_index())] = true;
                end
            end
            --self.Logger:Log_Finished();
        end,
        true
    );

    -- Checks if a character should attempt to be replaced
    core:add_listener(
        "MC_CC_CharacterCreated",
        "CharacterCreated",
        function(context)
            local char = context:character();
            local faction = char:faction();
            return (cm:char_is_mobile_general_with_army(char)
            -- Should restrict this to fresh characters
            and char:battles_fought() == 0
            -- We let humans do whatever they want
            and not faction:is_human()
            -- Faction leaders should not be replaced, although battles fought should be more than 0
            and not char:is_faction_leader()
            -- We blacklist some factions from generating for various reasons
            and self:IsExcludedFaction(faction) == false
            -- Naturally we don't want to process a character that isn't supported
            and IsCharacterSupported(char)
            -- Ignore characters spawning in the chaos wastes or on the ocean, this should
            -- fix most of the chaos invasion spawns
            and char:has_region()
            and char:turns_at_sea() == 0
            -- and finally, if somehow they are still valid but we've already cached them, don't do it again
            and not self.CachedData.ExistingGenerals[tostring(char:command_queue_index())])
            -- For when testing in VSCode, is always false in game
            or _G.IsIDE == true;
        end,
        function(context)
            local character = context:character();
            -- This should never fire (char_is_mobile_general_with_army should handle this properly) but is handy to have a failsafe
            if character:character_type("colonel") and (character:military_force():is_armed_citizenry() == false or character:is_politician() == true) then
                self.Logger:Log("Found colonel, ignoring...");
                self.Logger:Log_Finished();
            else
                self:ProcessNewCharacter(character);
            end
        end,
        true
    );
end

function ControlledCharacters:ProcessNewCharacter(character)
    local faction = character:faction();
    local factionKey = faction:name();
    if faction:is_dead() then
        self.Logger:Log("Faction: "..factionKey.." is dead (or dead at start of turn). Ignoring...");
        self.Logger:Log_Finished();
        return;
    end
    if cm:char_is_mobile_general_with_army(character)
    and not character:is_faction_leader() then
        local replacementSubtype = self:GenerateSubtypeForFaction(character);
        local override = false;
        if replacementSubtype ~= character:character_subtype_key()
        or _G.IsIDE == true
        or override == true then
            self.Logger:Log("Replacing character subtype:  "..character:character_subtype_key().." with: "..replacementSubtype.." in faction: "..factionKey);
            self:ReplaceCharacter(character, replacementSubtype);
        else
            self.Logger:Log("Generated subtype: "..replacementSubtype.." is the same subtype in faction: "..factionKey..", Not replacing.");
        end
        self.Logger:Log("Character is in region: "..character:region():name());
        self.Logger:Log_Finished();
    end
end

function ControlledCharacters:GenerateSubtypeForFaction(originalCharacter)
    local faction = originalCharacter:faction();
    local character_list = faction:character_list();
    local characterSubtypeCounts = {};
    local validCharacterCount = 1;
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i);
        if not character:is_null_interface()
        and character:command_queue_index() ~= originalCharacter:command_queue_index() then
            if cm:char_is_mobile_general_with_army(character)
            or cm:char_is_agent(character) == true
            or character:is_wounded() == true then
                local characterSubtypeKey = character:character_subtype_key();
                if characterSubtypeCounts[characterSubtypeKey] == nil then
                    characterSubtypeCounts[characterSubtypeKey] = 1;
                else
                    characterSubtypeCounts[characterSubtypeKey] = characterSubtypeCounts[characterSubtypeKey] + 1;
                end
                validCharacterCount = validCharacterCount + 1;
            end
        end
    end
    --self.Logger:Log("Finished counting characters");
    local supportedCharacterSubtype = false;
    local validPools = {};
    local factionPoolResources = GetFactionPoolResources(faction);
    for poolKey, poolData in pairs(factionPoolResources.FactionPools) do
        local maxPoolPercentage = poolData.SubPoolMaxSize / factionPoolResources.LordPoolMaxSize * 100;
        local poolCount = 0;
        for agentKey, agentData in pairs(poolData.AgentSubTypes) do
            if characterSubtypeCounts[agentKey] ~= nil then
                poolCount = poolCount + characterSubtypeCounts[agentKey];
            else
                characterSubtypeCounts[agentKey] = 0;
            end
            if agentKey == originalCharacter:character_subtype_key() then
                supportedCharacterSubtype = true;
            end
        end
        local poolPercentage = poolCount / validCharacterCount * 100;
        if poolPercentage < maxPoolPercentage
        or poolCount < poolData.SubPoolInitialMinSize then
            validPools[poolKey] = {
                PoolKey = poolKey,
                PoolTotal = poolCount,
                Weighting = poolData.SubPoolMaxSize,
            };
        end
    end

    if supportedCharacterSubtype == false
    and IsCharacterSupported(originalCharacter) == false then
        return originalCharacter:character_subtype_key();
    end

    local selectedPoolData = GetRandomItemFromWeightedList(validPools);
    local selectedPool = factionPoolResources.FactionPools[selectedPoolData.PoolKey];
    local validAgentSubtypes = {};
    for agentKey, agentData in pairs(selectedPool.AgentSubTypes) do
        local limit = selectedPoolData.PoolTotal;
        if limit < selectedPool.SubPoolInitialMinSize then
            limit = selectedPool.SubPoolInitialMinSize;
        end
        local agentPercentage = characterSubtypeCounts[agentKey] / limit * 100;
        if agentPercentage < agentData.MaximumPercentage then
            validAgentSubtypes[agentKey] = agentKey;
        end
    end
    --self.Logger:Log("Finished finding valid agent subtypes");
    if validAgentSubtypes[originalCharacter:character_subtype_key()]
    or not next(validAgentSubtypes) then
        return originalCharacter:character_subtype_key();
    else
        return GetRandomObjectFromList(validAgentSubtypes);
    end
end

function ControlledCharacters:ReplaceCharacter(character, replacementSubType)
    local characterRegion = "";
    if character:has_region() == true then
        characterRegion = character:region():name();
    else
        characterRegion = "wh_main_ice_tooth_mountains_icedrake_fjord";
    end

    local invalidUnitList = false;
    local charUnitList = GetStringifiedUnitList(character);
    -- If no unit string is supplied, set it to the default value. Will be removed by the callback function, assuming this is the only unit.
    if charUnitList == "" then
        --self.Logger:Log("Character has no units");
        invalidUnitList = true;
    end
    charUnitList = "wh_main_grn_inf_savage_orcs";
    local xPosition, yPosition = cm:find_valid_spawn_location_for_character_from_position(character:faction():name(), character:logical_position_x(), character:logical_position_y(), true);

    --self.Logger:Log("xPosition is "..xPosition);
    --self.Logger:Log("yPosition is "..yPosition);
    if xPosition == -1 or yPosition == -1 then
        xPosition = character:logical_position_x() + 1;
        yPosition = character:logical_position_y();
    end
    local replacedCharacterIsFactionLeader = false;
    if not character:faction():faction_leader():is_null_interface()
    and character:cqi() == character:faction():faction_leader():cqi() then
        replacedCharacterIsFactionLeader = true;
    end

    local characterForename = "";
    local characterSurname = "";
    local canOriginalUseFemaleName = self.CharacterGenerator:GetGenderForAgentSubType(character:character_subtype_key());
    local canReplacementUseFemaleName = self.CharacterGenerator:GetGenderForAgentSubType(replacementSubType);
    --self.Logger:Log("canOriginalUseFemaleName: "..tostring(canOriginalUseFemaleName));
    --self.Logger:Log("canReplacementUseFemaleName: "..tostring(canReplacementUseFemaleName));
    if canOriginalUseFemaleName ~= canReplacementUseFemaleName then
        --self.Logger:Log("Generating gender specific name");
        local generatedName = self.CharacterGenerator:GetCharacterNameForSubculture(character:faction(), replacementSubType);
        characterForename = generatedName.clan_name;
        characterSurname = generatedName.forename;
    else
        --self.Logger:Log("Using original name");
        characterForename = character:get_forename();
        characterSurname = character:get_surname();
    end
    local characterData = {
        oldCharCqi = character:command_queue_index(),
        mfCqi = character:military_force():command_queue_index(),
        factionName = character:faction():name(),
        subculture = character:faction():subculture(),
        unitList = charUnitList,
        regionName = characterRegion,
        xPos = xPosition,
        yPos = yPosition,
        subType = replacementSubType,
        foreName = characterForename,
        surname = characterSurname,
        isFactionLeader = replacedCharacterIsFactionLeader;
        noUnits = invalidUnitList,
    };
    if characterData.noUnits == true
    or characterData.noUnits == false then
        cm:callback(function() self:CreateReplacementCharacter(characterData); end, 0);
    end
end

function ControlledCharacters:CreateReplacementCharacter(character)
    --self.Logger:Log("CreateReplacementCharacter");
    cm:create_force_with_general(
        character.factionName,
        character.unitList,
        character.regionName,
        -- X and Y coordinates are used as identifiers in the callback.
        -- So we offset by a little bit to make it unique. This might
        -- cause issues if the position is invalid but an offset of 1
        -- is very small.
        character.xPos + 1,
        character.yPos,
        "general",
        character.subType,
        character.foreName,
        "",
        character.surname,
        "",
        character.isFactionLeader,
        function(cqi)
            self.Logger:Log("In created character callback for faction "..character.factionName.." with subtype "..character.subType);
            self.Logger:Log("Character cqi is "..cqi.." old character cqi is: "..character.oldCharCqi);
            -- Move character back to original position
            cm:teleport_to("character_cqi:"..cqi, character.xPos, character.yPos, true);
            if character.noUnits then
                self.Logger:Log("Character has no units");
                -- This is added to a callback because more time is required if the character was
                -- made a faction leader. Without the callback is_faction_leader always returned false
                if character.isFactionLeader == true then
                    cm:set_character_immortality("character_cqi:"..cqi, true);
                end
                cm:zero_action_points("character_cqi:"..cqi);
                cm:remove_unit_from_character("character_cqi:"..cqi, "wh_main_grn_inf_savage_orcs");
                self.CachedData.ExistingGenerals[tostring(cqi)] = true;
                cm:callback(function()
                    self.Logger:Log("Checking for colonels in the same location in faction: "..character.factionName);
                    local factionToCheck = cm:get_faction(character.factionName);
                    local character_list = factionToCheck:character_list();
                    for i = 0, character_list:num_items() - 1 do
                        local factionCharacter = character_list:item_at(i);
                        local agentType = factionCharacter:character_type_key();
                        --self.Logger:Log("Agent type is: "..agentType);
                        if factionCharacter:character_type("colonel") then
                            --[[self.Logger:Log("Found potential (invalid) colonel");
                            self.Logger:Log("logical_position_x: "..factionCharacter:logical_position_x().." Original x + 1: "..(character.xPos + 1));
                            self.Logger:Log("logical_position_y: "..factionCharacter:logical_position_y().." Original y: "..character.yPos);--]]
                            if factionCharacter:logical_position_x() == (character.xPos + 1)
                            and factionCharacter:logical_position_y() == character.yPos then
                                self.Logger:Log("Killing colonel");
                                cm:kill_character(factionCharacter:command_queue_index(), true, true);
                            end
                        end
                    end
                    self.Logger:Log_Finished();
                end,
                0.1);
            else
                self.Logger:Log("Character has preexisting units");
                cm:set_character_immortality("character_cqi:"..cqi, true);
                core:add_listener(
                    "MC_CC_CharacterConvalescedOrKilledAppointToArmy_"..cqi,
                    "CharacterConvalescedOrKilled",
                    function(context)
                        return cqi == context:character():command_queue_index();
                    end,
                    function(context)
                        self.Logger:Log("MC_CC_CharacterConvalescedOrKilledAppointToArmy Listener");
                        local characterCqi = context:character():command_queue_index();
                        local factionKey = context:character():faction():name();
                        cm:callback(function()
                            self.Logger:Log("In callback");
                            local faction = cm:get_faction(factionKey);
                            if faction ~= false
                            and not faction:is_null_interface()
                            and not faction:is_dead() then
                                local char = cm:get_character_by_cqi(characterCqi);
                                if char ~= false
                                and not char:is_null_interface()
                                and char:is_wounded() == true then
                                    self.Logger:Log("Revived character: "..characterCqi.." Appointing to mf "..character.mfCqi);
                                    cm:appoint_character_to_force("character_cqi:"..characterCqi, character.mfCqi);
                                else
                                    self.Logger:Log("Looking for alternative character: "..characterCqi);
                                    local character_list = faction:character_list();
                                    for i = 0, character_list:num_items() - 1 do
                                        local factionCharacter = character_list:item_at(i);
                                        if factionCharacter:character_subtype_key() == character.subType
                                        and factionCharacter:get_forename() == character.foreName
                                        and factionCharacter:get_surname() == character.surname
                                        and not factionCharacter:character_type("colonel") then
                                            local newCharacterCqi = factionCharacter:command_queue_index();
                                            if factionCharacter:is_wounded() then
                                                self.Logger:Log("Reviving character: "..newCharacterCqi)
                                                cm:stop_character_convalescing(newCharacterCqi);
                                            end
                                            self.Logger:Log("Appointing to mf "..character.mfCqi);
                                            local factionCharacterCqi = factionCharacter:command_queue_index();
                                            -- This should be in a callback in case the character needs to be revived
                                            cm:callback(function()
                                                self.Logger:Log("Appointing character: "..factionCharacterCqi.." to force: "..character.mfCqi);
                                                cm:appoint_character_to_force("character_cqi:"..factionCharacterCqi, character.mfCqi);
                                                self.Logger:Log_Finished();
                                            end,
                                            0.2);
                                            self.CachedData.ExistingGenerals[tostring(newCharacterCqi)] = true;
                                            break;
                                        end
                                    end
                                end
                            else
                                self.Logger:Log("Wounded char is null interface or missing");
                            end
                            self.Logger:Log_Finished();
                        end,
                        0.5);
                    end,
                    false
                );
                cm:callback(function()
                    local char = cm:get_character_by_cqi(cqi);
                    if char
                    and not char:is_null_interface() then
                        self.Logger:Log("Killing character and force: "..cqi);
                        cm:kill_character(cqi, true, true);
                        self.Logger:Log_Finished();
                    else
                        self.Logger:Log("Can't kill character, because null or missing");
                        core:remove_listener("MC_CC_CharacterConvalescedOrKilledAppointToArmy_"..cqi);
                        self.Logger:Log_Finished();
                    end
                end,
                0.1);
            end
            self.Logger:Log_Finished();
        end
    );
    -- This is needed for Tomb kings and other immortal characters.
    -- For others this isn't needed but it doesn't hurt to ensure they stay dead.
    core:add_listener(
        "MC_CC_CharacterConvalescedOrKilled_ImmortalKiller_"..character.oldCharCqi,
        "CharacterConvalescedOrKilled",
        function(context)
            return character.oldCharCqi == context:character():command_queue_index()
            and not context:character():character_type("colonel");
        end,
        function(context)
            local convalescedCharacter = context:character();
            if not convalescedCharacter:is_null_interface() then
                self.Logger:Log("Stopping character from convalescing: "..character.oldCharCqi);
                cm:stop_character_convalescing(character.oldCharCqi);
            else
                self.Logger:Log("Convalesced character is null interface: "..character.oldCharCqi);
            end
            --cm:callback(function() cm:disable_event_feed_events(false, "", "", "character_ready_for_duty") end, 0.1);
            self.Logger:Log_Finished();
        end,
        false
    );
    local charLookup = cm:char_lookup_str(character.oldCharCqi);
    cm:set_character_immortality(charLookup, false);
    -- We do only want to kill the military force, if they have 'no units' (aside from the one we had to give it)
    cm:kill_character(character.oldCharCqi, character.noUnits, true);
end

function ControlledCharacters:IsExcludedFaction(faction)
    local factionName = faction:name();
    if factionName == "wh_main_grn_skull-takerz" then
        return false;
    end
    --self.Logger:Log("Checking faction is excluded: "..factionName);
    if factionName == "rebels" or
    faction:is_quest_battle_faction() == true or
    string.match(factionName, "waaagh") ~= nil or
    string.match(factionName, "brayherd") ~= nil or
    string.match(factionName, "intervention") ~= nil or
    string.match(factionName, "incursion") ~= nil or
    string.match(factionName, "separatists") ~= nil or
    factionName == "wh2_dlc13_lzd_defenders_of_the_great_plan" or
    factionName == "wh_dlc03_bst_beastmen_chaos" or
    factionName == "wh2_dlc11_cst_vampire_coast_encounters" or
    factionName == "wh_main_nor_bjornling"
    then
        --self.Logger:Log("Faction is excluded");
        return true;
    end
    --self.Logger:Log("Faction is not excluded");
    return false;
end