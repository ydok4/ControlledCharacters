function GetWezSpeshulSavageOrcRecruitmentPoolData()
    return {
        -- Default pool distribution
        wh_main_sc_grn_savage_orcs = {
            FactionPools = {
                SavageOrcWarbosses = {
                    AgentSubTypes = {
                        -- Disable Mixu's stuff
                        grn_savage_orc_warboss = false,
                        ws_savage_orc_warboss = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
                SavageOrcShamans = {
                    AgentSubTypes = {
                        -- Disable Mixu's stuff
                        grn_savage_orc_shaman = false,
                        ws_savage_orc_great_shaman = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
            },
            LordsToReplace = {
                grn_orc_warboss = {
                    replacementKey = "ws_savage_orc_warboss",
                },
            },
        },
        --[[wh2_main_grn_blue_vipers = {
            FactionPools = {
                SavageOrcShamans = {
                    AgentSubTypes = {
                        grn_savage_orc_shaman = false,
                        ws_savage_orc_great_shaman = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
            },
            LordsToReplace = false,
        },--]]
    };
end