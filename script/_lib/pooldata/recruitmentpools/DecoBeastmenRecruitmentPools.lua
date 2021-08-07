function GetDecoBeastmenResources()
    return {
        -- Default pool distribution
        wh_dlc03_sc_bst_beastmen = {
            FactionPools = {
                GreatBrayShamans = {
                    AgentSubTypes = {
                        bst_bray_shaman_beasts = {
                            MaximumPercentage = 33,
                        },
                        bst_bray_shaman_death = {
                            MaximumPercentage = 33,
                        },
                        bst_bray_shaman_wild = {
                            MaximumPercentage = 33,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
            },
        },
    };
end