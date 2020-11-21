require 'script/_lib/pooldata/recruitmentpools/BeastmenRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/BretonniaRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/ChaosRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/DarkElfRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/DwarfRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/EmpireRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/GreenskinRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/KislevRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/SavageOrcRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/HighElfRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/LizardmenRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/NorscaRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/SkavenRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/TEBRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/TombKingsRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/VampireCoastRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/VampireCountsRecruitmentPools'
require 'script/_lib/pooldata/recruitmentpools/WoodElfRecruitmentPools'
--require 'script/_lib/pooldata/SharedRecruitmentPools'

out("MC_CC: Loading Core Data");

_G.MC_CC_Resources = {
    RecruitmentPoolResources = {
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = GetBeastmenRecruitmentPoolData(),
        -- Bretonnia
        wh_main_sc_brt_bretonnia = GetBretonniaRecruitmentPoolData(),
        -- Chaos
        wh_main_sc_chs_chaos = GetChaosRecruitmentPoolData(),
        -- Dark Elves
        wh2_main_sc_def_dark_elves = GetDarkElfRecruitmentPoolData(),
        -- Dwarfs
        wh_main_sc_dwf_dwarfs = GetDwarfRecruitmentPoolData(),
        -- Empire
        wh_main_sc_emp_empire = GetEmpireRecruitmentPoolData(),
        -- Greenskins
        wh_main_sc_grn_greenskins = GetGreenskinRecruitmentPoolData(),
        wh_main_sc_grn_savage_orcs = GetSavageOrcRecruitmentPoolData(),
        -- Kislev
        wh_main_sc_ksl_kislev = GetKislevRecruitmentPools(),
        -- High Elf
        wh2_main_sc_hef_high_elves = GetHighElfRecruitmentPoolData(),
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = GetLizardmenRecruitmentPoolData(),
        -- Norsca
        wh_main_sc_nor_norsca = GetNorscaRecruitmentPoolData(),
        -- Skaven
        wh2_main_sc_skv_skaven = GetSkavenRecruitmentPoolData(),
        -- TEB
        wh_main_sc_teb_teb = GetTEBRecruitmentPools(),
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = GetTombKingsRecruitmentPools(),
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = GetVampireCoastRecruitmentPoolData(),
        -- Vampire Counts
        wh_main_sc_vmp_vampire_counts = GetVampireCountsRecruitmentPoolData(),
        -- Wood Elf
        wh_dlc05_sc_wef_wood_elves = GetWoodElfRecruitmentPoolData(),
        -- OvN Custom subcultures
        --[[wh_main_sc_nor_albion = GetAlbionRecruitmentPoolData(),
        wh_main_sc_nor_fimir = GetFimirRecruitmentPoolData(),
        wh_main_sc_nor_troll = GetTrollRecruitmentPoolData(),
        wh_main_sc_nor_warp = GetWarpRecruitmentPoolData(),--]]
        -- Shared Data (Traits mainly)
        --shared = SharedRecruitmentPoolData,

        -- Rogue Armies
        --wh_rogue_armies = RogueArmyRecruitmentPoolData,
    },

    -- Additional loader function
    -- This is intended to be used by other mods to load custom data.
    -- This can be used to change agent sub type distribution or add
    -- new agent sub types into the system.
    AddAdditionalRecruitmentPoolResources = function (subculture, resources)
        local coreResources = _G.MC_CC_Resources.RecruitmentPoolResources[subculture];

        for key1, additionalFactionData in pairs(resources) do
            if additionalFactionData.FactionPools ~= nil then
                for key2, additionalSubPoolData in pairs(additionalFactionData.FactionPools) do
                    if type(additionalSubPoolData) == "table" then
                        if coreResources[key1] == nil then
                            coreResources[key1] = additionalFactionData;
                        else
                            local existingData = coreResources[key1].FactionPools[key2];
                            if existingData == nil then
                                coreResources[key1].FactionPools[key2] = additionalSubPoolData;
                            else
                                local additionalAgentSubTypes = {};
                                local agentSubTypes = additionalSubPoolData.AgentSubTypes;
                                if agentSubTypes ~= nil then
                                    for key3, subPool in pairs(agentSubTypes) do
                                        -- If an agent has been marked for deletion from a pool
                                        if subPool == false then
                                            if existingData.AgentSubTypes == nil then
                                                existingData.AgentSubTypes = {};
                                            end
                                            existingData.AgentSubTypes[key3] = false;
                                        else
                                            additionalAgentSubTypes[key3] = subPool;
                                        end
                                    end
                                end
                                if existingData.AgentSubTypes == nil then
                                    existingData.AgentSubTypes = {};
                                end
                                -- Add all the new agent sub types
                                ConcatTableWithKeys(existingData.AgentSubTypes, additionalAgentSubTypes);
                                if additionalSubPoolData.SubPoolInitialMinSize ~= nil then
                                    existingData.SubPoolInitialMinSize = additionalSubPoolData.SubPoolInitialMinSize;
                                end

                                if additionalSubPoolData.SubPoolMaxSize ~= nil then
                                    existingData.SubPoolMaxSize = additionalSubPoolData.SubPoolMaxSize;
                                end
                            end
                        end
                    -- If a pool has been marked for deletion or there are no longer any agent
                    -- subTypes in it, remove the data
                    elseif additionalSubPoolData == false or TableHasAnyValue(coreResources[key1].FactionPools[key2]) == false then
                        coreResources[key1].FactionPools[key2] = nil;
                    end
                end
            end
            if additionalFactionData.LordPoolMaxSize ~= nil then
                coreResources[key1].LordPoolMaxSize = additionalFactionData.LordPoolMaxSize;
            end
            -- Merge replacement data
            if additionalFactionData.LordsToReplace ~= nil then
                if coreResources[key1].LordsToReplace == nil then
                    coreResources[key1].LordsToReplace = {};
                end
                if coreResources[key1].LordsToReplace == false then
                    coreResources[key1].LordsToReplace = nil;
                else
                    ConcatTableWithKeys(coreResources[key1].LordsToReplace, additionalFactionData.LordsToReplace);
                end
            end
        end
    end,
    AddAdditionalDBResources = function(dbResourceKey, resourceData)
        ConcatTableWithKeys(_G.MC_CC_Resources.DBResources[dbResourceKey], resourceData);
    end,
}

require 'script/_lib/dbexports/AgentDataResources'
require 'script/_lib/dbexports/NameGenerator/SubCultureNameGroupResources'
require 'script/_lib/dbexports/NameGenerator/NameGroupResources'
require 'script/_lib/dbexports/NameGenerator/NameResources'
-- Load the name resources
-- This is separate so I can use this in other mods
if not _G.CG_NameResources then
    _G.CG_NameResources = {
        ConcatTableWithKeys = function(self, destinationTable, sourceTable)
            for key, value in pairs(sourceTable) do
                destinationTable[key] = value;
            end
        end,
        subculture_to_name_groups = GetSubCultureNameGroupResources(),
        faction_to_name_groups = GetNameGroupResources(),
        name_groups_to_names = GetNameResources(),
        campaign_character_data = GetAgentDataResources(),
    };
end