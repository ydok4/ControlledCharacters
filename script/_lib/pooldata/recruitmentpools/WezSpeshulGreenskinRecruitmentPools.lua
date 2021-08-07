
function GetWezSpeshulGreenskinRecruitmentPoolData()
    -- This is designed to be paired with Mixu's TTL
    return {
        -- Default pool distribution
        wh_main_sc_grn_greenskins = {
            FactionPools = {
                GreenskinShamans = {
                    AgentSubTypes = {
                        grn_savage_orc_shaman = false,
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_orc_great_shaman = {
                            MaximumPercentage = 50,
                        },
                        ws_savage_orc_great_shaman = {
                            MaximumPercentage = 25,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
            },
        },
        -- Major Faction specific distributions
        -- Grimgor
        wh_main_grn_greenskins = {
            FactionPools = {
                GreenskinWarbosses = {
                    AgentSubTypes = {
                        ws_black_orc_warboss = {
                            MaximumPercentage = 50,
                        },
                        grn_orc_warboss = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
                GreenskinShamans = {
                    AgentSubTypes = {
                        grn_savage_orc_shaman = false,
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_orc_great_shaman = {
                            MaximumPercentage = 50,
                        },
                        ws_savage_orc_great_shaman = {
                            MaximumPercentage = 25,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
        },

        -- Wurrzag
        wh_main_grn_orcs_of_the_bloody_hand = {
            FactionPools = {
                GreenskinShamans = {
                    AgentSubTypes = {
                        grn_savage_orc_shaman = false,
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_orc_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        ws_savage_orc_great_shaman = {
                            MaximumPercentage = 50,
                        },
                    },
                },
            },
        },

        -- Ahzag
        wh2_dlc15_grn_bonerattlaz = {
            FactionPools = {
                GreenskinWarbosses = {
                    AgentSubTypes = {
                        dlc06_grn_night_goblin_warboss = {
                            MaximumPercentage = 50,
                        },
                        grn_orc_warboss = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 4,
                },
                GreenskinShamans = {
                    AgentSubTypes = {
                        -- Disable Mixus stuff
                        grn_savage_orc_shaman = false,
                        grn_goblin_great_shaman = false,
                        ws_night_goblin_great_shaman = {
                            MaximumPercentage = 50,
                        },
                        grn_orc_great_shaman = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
        },

        -- Skarsnik
        wh_main_grn_crooked_moon = {
            FactionPools = {
                GreenskinShamans = {
                    AgentSubTypes = {
                        ws_night_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 75,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordsToReplace = {
                grn_orc_warboss = {
                    replacementKey = "dlc06_grn_night_goblin_warboss",
                },
            },
            LordPoolMaxSize = 4,
        },

        -- Night Goblin Tribes
        wh_main_grn_necksnappers = {
            FactionPools = {
                GreenskinWarbosses = {
                    AgentSubTypes = {
                        dlc06_grn_night_goblin_warboss = {
                            MaximumPercentage = 25,
                        },
                        grn_orc_warboss = {
                            MaximumPercentage = 75,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 4,
                },
                GreenskinShamans = {
                    AgentSubTypes = {
                        ws_night_goblin_great_shaman = {
                            MaximumPercentage = 100,
                        },
                        grn_goblin_great_shaman = false,
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
        },
        wh_main_grn_bloody_spearz = {
            FactionPools = {
                GreenskinShamans = {
                    AgentSubTypes = {
                        ws_night_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 75,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
            LordsToReplace = {
                grn_orc_warboss = {
                    replacementKey = "dlc06_grn_night_goblin_warboss",
                },
                grn_goblin_great_shaman = {
                    replacementKey = "ws_night_goblin_great_shaman",
                },
            },
        },
        wh_main_grn_red_eye = {
            FactionPools = {
                GreenskinShamans = {
                    AgentSubTypes = {
                        ws_night_goblin_great_shaman = {
                            MaximumPercentage = 25,
                        },
                        grn_goblin_great_shaman = {
                            MaximumPercentage = 75,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
            LordsToReplace = {
                grn_orc_warboss = {
                    replacementKey = "dlc06_grn_night_goblin_warboss",
                },
                grn_goblin_great_shaman = {
                    replacementKey = "ws_night_goblin_great_shaman",
                },
            },
        },
    };
end