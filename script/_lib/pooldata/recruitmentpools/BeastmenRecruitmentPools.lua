function GetBeastmenRecruitmentPoolData()
    return {
        -- Default pool distribution
        wh_dlc03_sc_bst_beastmen = {
            HeroPools = {
                BrayShamans = {
                    AgentSubTypes = {
                        dlc03_bst_bray_shaman_beasts = {
                            MaximumPercentage = 25,
                        },
                        dlc03_bst_bray_shaman_death = {
                            MaximumPercentage = 25,
                        },
                        dlc03_bst_bray_shaman_shadows = {
                            MaximumPercentage = 25,
                        },
                        dlc03_bst_bray_shaman_wild = {
                            MaximumPercentage = 25,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
                GoreBulls = {
                    AgentSubTypes = {
                        dlc03_bst_gorebull = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 0,
                },
            },
            HeroPoolMaxSize = 4,
            FactionPools = {
                BeastLords = {
                    AgentSubTypes = {
                        dlc03_bst_beastlord = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 5,
                },
                GreatBrayShamans = {
                    AgentSubTypes = {
                        wh2_twa04_bst_great_bray_shaman_beasts = {
                            MaximumPercentage = 25,
                        },
                        wh2_twa04_bst_great_bray_shaman_death = {
                            MaximumPercentage = 25,
                        },
                        wh2_twa04_bst_great_bray_shaman_shadows = {
                            MaximumPercentage = 25,
                        },
                        wh2_twa04_bst_great_bray_shaman_wild = {
                            MaximumPercentage = 25,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
                DoomBulls = {
                    AgentSubTypes = {
                        wh2_dlc17_bst_doombull = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 5,
        },
        -- Main Beastmen faction
        -- Khazrak
        wh_dlc03_bst_beastmen = {
            FactionPools = {
                BeastLords = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 6,
                },
            },
            LordPoolMaxSize = 5,
        },
        -- Malagor
        wh2_dlc17_bst_malagor = {
            FactionPools = {
                GreatBrayShamans = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
            },
            LordPoolMaxSize = 5,
        },
        -- Taurox
        wh2_dlc17_bst_taurox = {
            FactionPools = {
                DoomBulls = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 3,
                },
            },
            LordPoolMaxSize = 5,
        },
        -- Morghor
        wh_dlc05_bst_morghur_herd = {
            FactionPools = {
                BeastLords = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 6,
                },
            },
            LordPoolMaxSize = 5,
        },
    };
end