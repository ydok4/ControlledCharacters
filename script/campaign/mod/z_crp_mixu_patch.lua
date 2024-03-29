if core:is_mod_loaded("mixu_ttl") then
    --require 'script/_lib/pooldata/recruitmentpools/MixuBeastmenRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuChaosRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuDwarfsRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuEmpireRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuGreenskinRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuNorscaRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuSavageOrcRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuTombKingsRecruitmentPools'
    require 'script/_lib/pooldata/recruitmentpools/MixuWoodElfRecruitmentPools'

    out("MC_CC: Loading Mixu Patch");
    --_G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_dlc03_sc_bst_beastmen", GetMixuBeastmenRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_chs_chaos", GetMixuChaosRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_dwf_dwarfs", GetMixuDwarfsRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_emp_empire", GetMixuEmpireRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_grn_greenskins", GetMixuGreenskinRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_nor_norsca", GetMixuNorscaRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_grn_savage_orcs", GetMixuSavageOrcRecruitmentPoolData());
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh2_dlc09_sc_tmb_tomb_kings", GetMixuTombKingsRecruitmentPools());
    --_G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_dlc05_sc_wef_wood_elves", GetMixuWoodElfRecruitmentPoolData());

    require 'script/_lib/dbexports/MixuDataResources'
    out("MC_CC: Loading Mixu Data");
    -- Load the name resources
    -- This is separate so I can use this in other mods
    if _G.CG_NameResources then
        _G.CG_NameResources:ConcatTableWithKeys(_G.CG_NameResources.campaign_character_data, GetMixuDataResources());
    end
    out("MC_CC: Finished loading Mixu Patch");
end

--[[if core:is_mod_loaded("mixu_shadewraith") then
    require 'script/_lib/pooldata/recruitmentpools/MixuVampireCoastRecruitmentPools'
    --_G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh2_dlc11_sc_cst_vampire_coast", GetMixuVampireCoastRecruitmentPoolData());
end--]]