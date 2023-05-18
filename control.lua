local firstRefill = false;
local refillOreEnabled = settings.global["resource-refill-ore-enabled"].value;
local refillOreAmount = settings.global["resource-refill-amount-ore"].value;
local refillOilEnabled = settings.global["resource-refill-oil-enabled"].value;
local refillOilAmount = settings.global["resource-refill-amount-oil"].value * 3000; -- percentage times 3000
local refillOilInterval = settings.global["resource-refill-interval-oil"].value * 60; -- ticks (18000 = 5min)

function _log(...)
  log(serpent.block(..., {comment = false}))
end

script.on_init(function()
  firstRefill = true;
end);

function refillResources(resources)
  for _, entity in pairs(resources) do
    if entity.name == "crude-oil" then
      if refillOilEnabled then
        entity.amount = refillOilAmount;
      end
    else
      if refillOreEnabled then
        entity.amount = refillOreAmount;
      end
    end
  end
end

function refillAllResources()
  for _, surface in pairs(game.surfaces) do
    refillResources(surface.find_entities_filtered({
      type = "resource"
    }));
  end
end

function refillOilResources()
  for _, surface in pairs(game.surfaces) do
    refillResources(surface.find_entities_filtered({
      name = "crude-oil"
    }));
  end
end

function onTick(event)
  if firstRefill then
    firstRefill = false;
    refillAllResources();
  elseif event.tick % refillOilInterval == 0 then
    refillOilResources();
  end
end

function onChunkGenerated(event)
  refillResources(event.surface.find_entities_filtered({
    area = event.area,
    type = "resource"
  }));
end

function onResourceDepleted(event)
  if event.entity.name == "crude-oil" then
    if refillOilEnabled then
      event.entity.amount = refillOilAmount;
    end
  else
    if refillOreEnabled then
      event.entity.amount = refillOreAmount;
    end
  end
end

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  refillOreEnabled = settings.global["resource-refill-ore-enabled"].value;
  refillOreAmount = settings.global["resource-refill-amount-ore"].value;
  refillOilEnabled = settings.global["resource-refill-oil-enabled"].value;
  refillOilAmount = settings.global["resource-refill-amount-oil"].value * 3000;
  refillOilInterval = settings.global["resource-refill-interval-oil"].value * 60;
end)

-- Increase resource amount when generated
script.on_event(defines.events.on_chunk_generated, onChunkGenerated);
-- Refill resources on depletion
script.on_event(defines.events.on_resource_depleted, onResourceDepleted);
-- Refill oil based on the timer setting
script.on_event(defines.events.on_tick, onTick);