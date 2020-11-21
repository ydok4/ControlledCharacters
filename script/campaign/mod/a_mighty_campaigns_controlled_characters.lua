MC_CC = {};
_G.MC_CC = MC_CC;

-- Helpers
require 'script/_lib/core/helpers/MC_DataHelpers';
require 'script/_lib/core/helpers/MC_LoadHelpers';
require 'script/_lib/core/helpers/MC_SaveHelpers';
require 'script/_lib/core/helpers/resourcehelpers';
-- Loaders
require 'script/_lib/core/loaders/core_resource_loader';
-- Models
require 'script/_lib/core/model/ControlledCharacters';
require 'script/_lib/core/model/CharacterGenerator';
require 'script/_lib/core/model/Logger';

function a_mighty_campaigns_controlled_characters()
    out("MC_CC: Main mod function");
    local enableLogging = true;
    InitialiseResourcesCache();
    MC_CC = ControlledCharacters:new({});
    MC_CC:Initialise(core, enableLogging);
    MC_CC.Logger:Log("Initialised");
    MC_CC.Logger:Log_Finished();
    _G.MC_CC = MC_CC;
    out("MC_CC: Finished setup");
end