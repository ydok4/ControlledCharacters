function GetMixuPoolData()
    return {
        wh_main_sc_chs_chaos = {
            -- The Cabal Faction, this is only present with an unlocker (Mixus's or Crynsos)
            wh2_main_chs_the_cabal = {
                FactionPools = {
                    ChaosLord = {
                        AgentSubTypes = {
                            chs_lord = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 1,
                        SubPoolMaxSize = 4,
                    },
                    SorcerorLords = {
                        AgentSubTypes = {
                            chs_sorcerer_lord_death = {
                                MaximumPercentage = 25,
                            },
                            chs_sorcerer_lord_fire = {
                                MaximumPercentage = 25,
                            },
                            chs_sorcerer_lord_metal = {
                                MaximumPercentage = 25,
                            },
                            dlc07_chs_sorcerer_lord_shadow = {
                                MaximumPercentage = 25,
                            },
                        },
                        SubPoolInitialMinSize = 3,
                        SubPoolMaxSize = 4,
                    },
                },
                LordPoolMaxSize = 4,
            },
        },
        wh_main_sc_dwf_dwarfs = {
            -- Default pool distribution
            wh_main_sc_dwf_dwarfs = {
                HeroPools = {
                    DragonSlayers = {
                        AgentSubTypes = {
                            dwf_giant_slayer = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 0,
                        SubPoolMaxSize = 2,
                    },
                },
            },
            -- Karak Kadrin
            --[[wh_main_dwf_karak_kadrin = {
                HeroPools = {
                    DragonSlayers = {
                        AgentSubTypes = {
                            dwf_giant_slayer = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 1,
                        SubPoolMaxSize = 4,
                    },
                    MasterEngineers = {
                        AgentSubTypes = {
                            dwf_master_engineer = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 0,
                        SubPoolMaxSize = 2,
                    },
                    Runesmiths = {
                        AgentSubTypes = {
                            dwf_runesmith = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 0,
                        SubPoolMaxSize = 2,
                    },
                    Thanes = {
                        AgentSubTypes = {
                            dwf_thane = {
                                MaximumPercentage = 100,
                            },
                        },
                        SubPoolInitialMinSize = 1,
                        SubPoolMaxSize = 4,
                    },
                },
                FactionPools = {
                    DaemonSlayers = {
                        AgentSubTypes = {
                            dwf_daemon_slayer = {
                                MaximumPercentage = 100,
                                BonusCost = 0,
                            },
                        },
                        SubPoolInitialMinSize = 1,
                        SubPoolMaxSize = 1,
                    },
                },
            },--]]
        }
    };
end