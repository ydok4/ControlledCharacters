function GetWoodElfRecruitmentPoolData()
    return {
        -- Default pool distribution
        wh_dlc05_sc_wef_wood_elves = {
            HeroPools = {
                Spellsingers = {
                    AgentSubTypes = {
                        dlc05_wef_spellsinger_beasts = {
                            MaximumPercentage = 33,
                        },
                        dlc05_wef_spellsinger_life  = {
                            MaximumPercentage = 33,
                        },
                        dlc05_wef_spellsinger_shadow  = {
                            MaximumPercentage = 33,
                        },
                    },
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
                Waystalkers = {
                    AgentSubTypes = {
                        dlc05_wef_waystalker = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 0,
                },
                BranchWraiths = {
                    AgentSubTypes = {
                        wh_dlc05_wef_branchwraith = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 0,
                },
            },
            HeroPoolMaxSize = 4,
            FactionPools = {
                GladeLords = {
                    AgentSubTypes = {
                        dlc05_wef_glade_lord = {
                            MaximumPercentage = 50,
                        },
                        dlc05_wef_glade_lord_fem = {
                            MaximumPercentage = 50,
                        },
                    },
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 5,
                },
                SpellWeavers = {
                    AgentSubTypes = {
                        wh2_dlc16_wef_spellweaver_dark = {
                            MaximumPercentage = 20,
                        },
                        wh2_dlc16_wef_spellweaver_high = {
                            MaximumPercentage = 20,
                        },
                        wh2_dlc16_wef_spellweaver_beasts = {
                            MaximumPercentage = 20,
                        },
                        wh2_dlc16_wef_spellweaver_life = {
                            MaximumPercentage = 20,
                        },
                        wh2_dlc16_wef_spellweaver_shadows = {
                            MaximumPercentage = 20,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
                AncientTreeman = {
                    AgentSubTypes = {
                        dlc05_wef_ancient_treeman = {
                            MaximumPercentage = 100,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
                MaliciousTreeman = {
                    AgentSubTypes = {
                        wh2_dlc16_wef_malicious_ancient_treeman_beasts = {
                            MaximumPercentage = 33,
                        },
                        wh2_dlc16_wef_malicious_ancient_treeman_life = {
                            MaximumPercentage = 33,
                        },
                        wh2_dlc16_wef_malicious_ancient_treeman_shadows = {
                            MaximumPercentage = 33,
                        },
                    },
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 0,
                },
            },
            LordPoolMaxSize = 4,
        },

        -- Major Factions
        -- Orion
        wh_dlc05_wef_wood_elves = {
            FactionPools = {
                GladeLords = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 6,
                },
                SpellWeavers = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
                AncientTreeman = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
        },
        -- Durthu
        wh_dlc05_wef_argwylon = {
            FactionPools = {
                GladeLords = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
                SpellWeavers = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 2,
                },
                AncientTreeman = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 3,
                },
            },
            LordPoolMaxSize = 4,
        },
        -- Sisters of Twilight
        wh2_dlc16_wef_sisters_of_twilight = {
            FactionPools = {
                GladeLords = {
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 2,
                },
                SpellWeavers = {
                    SubPoolInitialMinSize = 2,
                    SubPoolMaxSize = 3,
                },
                AncientTreeman = {
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
            },
            LordPoolMaxSize = 4,
        },
        -- Drycha
        wh2_dlc16_wef_drycha = {
            FactionPools = {
                GladeLords = false,
                SpellWeavers = false,
                AncientTreeman = false,
                MaliciousTreeman = {
                    SubPoolInitialMinSize = 4,
                    SubPoolMaxSize = 4,
                },
            },
            LordPoolMaxSize = 4,
        },
        -- Minor Factions
        wh2_main_wef_bowmen_of_oreon = {
            FactionPools = {
                GladeLords = {
                    SubPoolInitialMinSize = 1,
                    SubPoolMaxSize = 4,
                },
                SpellWeavers = {
                    SubPoolInitialMinSize = 0,
                    SubPoolMaxSize = 1,
                },
            },
            AncientTreeman = false,
            LordPoolMaxSize = 4,
        },
    };
end