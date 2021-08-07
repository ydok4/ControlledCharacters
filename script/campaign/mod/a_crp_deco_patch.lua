function a_crp_deco_patch()
    local anyLoaded = false;
    if effect.get_localised_string("agent_subtypes_onscreen_name_override_wh_grn_forest_goblin_warboss") ~= "" then
        anyLoaded = true;
        require 'script/_lib/pooldata/recruitmentpools/DecoGreenskinRecruitmentPools'
        out("MC_CC: Loading Deco Goblin Patch");
        _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_grn_greenskins", GetDecoForestGoblinResources());
        out("MC_CC: Finished loading Deco Goblin Patch");
    end

    if effect.get_localised_string("agent_subtypes_onscreen_name_override_wh2_deco_warlord") ~= "" then
        anyLoaded = true;
        require 'script/_lib/pooldata/recruitmentpools/DecoKislevRecruitmentPools'
        out("MC_CC: Loading Deco Kislev Patch");
        _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_ksl_kislev", GetDecoKislevResources());
        out("MC_CC: Finished loading Deco Kislev Patch");
    end

    --[[if effect.get_localised_string("agent_subtypes_description_text_override_bst_bray_shaman_wild") ~= "" then
        out("MC_CC: Loading Deco Beastmen patch");
        require 'script/_lib/pooldata/recruitmentpools/DecoBeastmenRecruitmentPools'
        _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_dlc03_sc_bst_beastmen", GetDecoBeastmenResources());
    end--]]

    if anyLoaded == true then
        -- Load the name resources
        -- This is separate so I can use this in other mods
        require 'script/_lib/dbexports/DecoDataResources'
        if _G.CG_NameResources then
            ConcatTableWithKeys(_G.CG_NameResources.campaign_character_data, GetDecoAgentDataResources());
        end
    end
end