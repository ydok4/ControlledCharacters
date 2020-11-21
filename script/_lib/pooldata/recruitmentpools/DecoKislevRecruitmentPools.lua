function GetDecoKislevResources()
    return {
        -- Default Kislev distribution
        wh_main_sc_ksl_kislev = {
            FactionPools = {
                EmpireGenerals = false,
                KislevLeaders = {
                    AgentSubTypes = {
                        wh2_deco_voevoda = {
                            MaximumPercentage = 75,
                            HumanPlayerOnly = true,
                        },
                        wh2_deco_warlord = {
                            MaximumPercentage = 25,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 4,
                },
            },
        },
        -- Major Factions (Kislev)
        wh_main_ksl_kislev = {
            FactionPools = {
                EmpireGenerals = false,
                KislevLeaders = {
                    AgentSubTypes = {
                        wh2_deco_voevoda = {
                            MaximumPercentage = 75,
                            HumanPlayerOnly = true,
                        },
                        wh2_deco_warlord = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 4,
                },
            },
        },

        -- Minor Factions Praag
        wh_main_ksl_praag = {
            FactionPools = {
                KislevLeaders = {
                    AgentSubTypes = {
                        wh2_deco_voevoda = {
                            MaximumPercentage = 50,
                            HumanPlayerOnly = true,
                        },
                        wh2_deco_warlord = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
            },
            LordPoolMaxSize = 4,
        },
    };
end