out("MC_CC: Loading Cataph Patch");
local anyLoaded = false;
if core:is_mod_loaded("cataph_kraka") then
    anyLoaded = true;
    out("MC_CC: Loading kraka drak resources");
    require 'script/_lib/pooldata/recruitmentpools/CataphDwarfsRecruitmentPools'
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_dwf_dwarfs", GetCataphDwarfsRecruitmentPools());
end

if core:is_mod_loaded("cataph_aislinn") then
    anyLoaded = true;
    out("MC_CC: Loading sea helm resources resources");
    require 'script/_lib/pooldata/recruitmentpools/CataphHighElfSeaLordRecruitmentPools'
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh2_main_sc_hef_high_elves", GetCataphHighElfSeaLordRecruitmentPoolData());
end

if core:is_mod_loaded("cataph_teb") then
    anyLoaded = true;
    out("CRP: Loading teb resources");
    require 'script/_lib/pooldata/recruitmentpools/CataphTEBRecruitmentPools'
    _G.MC_CC_Resources.AddAdditionalRecruitmentPoolResources("wh_main_sc_teb_teb", GetTEBRecruitmentPools());
end

if anyLoaded == true then
    require 'script/_lib/dbexports/CataphDataResources'
    out("MC_CC: Loading Cataph Data");
    -- Load the name resources
    -- This is separate so I can use this in other mods
    if _G.CG_NameResources then
        _G.CG_NameResources:ConcatTableWithKeys(_G.CG_NameResources.campaign_character_data, GetCataphDataResources());
    end
end

out("MC_CC: Finished loading Cataph Patch");