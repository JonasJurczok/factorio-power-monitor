
require "mod-gui"
require "pmon/pmon"

-- when creating a new game, initialize data structure
script.on_init(pmon.mod_init)

-- When a player is joining, create the UI for them
--[[script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    pmon.create_ui(player)
end)]]--

-- if the version of the mod or any other version changed
script.on_configuration_changed(function(_)
    pmon.mod_init()
end)

script.on_event(defines.events.on_gui_click, function(event)
    pmon.on_gui_click(event)
end)

script.on_event(defines.events.on_tick, function(event)
    pmon.on_tick(event)
end)

script.on_event(defines.events.on_player_selected_area, function(event)
    pmon.on_player_selected_area(event)
end)

--[[
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    local player = game.players[event.player_index]
    local key = event.setting
    todo.on_runtime_mod_setting_changed(player, key)
end)
]]--
