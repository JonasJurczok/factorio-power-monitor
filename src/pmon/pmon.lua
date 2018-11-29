pmon = {}

function pmon.mod_init()
    if not global.pmon then
        global.pmon = {}
    end
end

function pmon.on_tick(event)
    if (event.tick % 10 == 0 and #global.pmon > 0) then

        pmon.mod_init()

        for _, monitor in pairs(global.pmon) do
            -- update data

        end

        -- update UI
        for _, player in pairs(game.players) do
            pmon.update_ui(player)
        end
    end
end

function pmon.update_ui(player)
    local frame = pmon.ensure_main_frame(player)

    for _, monitor in pairs(global.pmon) do
        pmon.ensure_static_info(frame, monitor)
        local bar = pmon.ensure_progress_bar(frame, monitor)
        bar.value = monitor.value
        -- TODO: color?
    end
end

function pmon.ensure_main_frame(player)

    local frame_flow = mod_gui.get_frame_flow(player)
    if (not frame_flow.pmon_main_frame) then
        frame_flow.add({
            type = "frame",
            name = "pmon_main_frame",
            direction = "vertical"
        })
    end

    return frame_flow.pmon_main_frame
end

function pmon.ensure_static_info(frame, monitor)
    local flow = pmon.ensure_horizontal_flow(frame, monitor)
    pmon.ensure_monitor_title(flow, monitor)
    --pmon.ensure_monitor_delete_button(flow, monitor)
end

function pmon.ensure_horizontal_flow(frame, monitor)

    local flow_name = "pmon_" .. monitor.name .. "_flow"

    if (frame[flow_name]) then
        return frame[flow_name]
    end

    return frame.add({
        type = "flow",
        name = flow_name,
        direction = "horizontal"
    })
end

function pmon.ensure_monitor_title(flow, monitor)
    local title_name = "pmon" .. monitor.name .. "_title"

    if (flow[title_name]) then
        return
    end

    flow.add({
        type = "label",
        style = "pmon_label_default",
        name = title_name,
        caption = monitor.title
    })
end

function pmon.ensure_monitor_delete_button(flow, monitor)

end

function pmon.ensure_progress_bar(frame, monitor)
    local bar_name = "pmon_" .. monitor.name .. "_progress_bar"

    if (frame[bar_name]) then
        return frame[bar_name]
    end

    local bar = frame.add({
        type = "progressbar",
        name = bar_name,
        value = monitor.value
    })
    bar.style.color = { r = 0, g = 1, b = 0, a = 1 }
    bar.style.horizontally_stretchable = true
    return bar
end

function pmon.on_gui_click(event)
    local player = game.players[event.player_index]
    local element = event.element

    if (element.name == "pmon_add_cancel_button") then
        pmon.get_add_dialog(player).destroy()
    elseif (element.name == "pmon_add_monitor_button") then
        pmon.add_monitor(player)
        pmon.get_add_dialog(player).destroy()
    end
end

function pmon.add_monitor(player)
    local dialog = pmon.get_add_dialog(player)
    local entity = dialog.pmon_add_entity.entity
    local title = dialog.pmon_add_dialog_flow.pmon_add_monitor_title.text

    local monitor = {}
    monitor.entity = entity
    monitor.title = title
    monitor.name = string.gsub(title, " ", "_")
    monitor.type = entity.prototype.type
    monitor.value = 0

    table.insert(global.pmon, monitor)

end

function pmon.create_add_dialog(player, entity)
    local gui = player.gui.center

    local old_dialog = pmon.get_add_dialog(player)
    if (old_dialog ~= nil) then
        old_dialog.destroy()
    end

    local dialog = gui.add({
        type = "frame",
        name = "pmon_add_dialog",
        caption = { "pmon.add_monitor" },
        direction = "vertical"
    })

    local preview = dialog.add({
        type = "entity-preview",
        name = "pmon_add_entity"
    })

    preview.entity = entity

    local flow = dialog.add({
        type = "flow",
        name = "pmon_add_dialog_flow",
        direction = "horizontal"
    })

    flow.add({
        type = "label",
        name = "pmon_add_label",
        caption = { "pmon.add_monitor_name" }
    })

    flow.add({
        type = "textfield",
        style = "pmon_textfield_default",
        name = "pmon_add_monitor_title"
    })

    local button_flow = dialog.add({
        type = "flow",
        name = "pmon_add_dialog_button_flow",
        direction = "horizontal"
    })

    local ok = button_flow.add({
        type = "button",
        style = "pmon_button_default",
        name = "pmon_add_monitor_button",
        caption = { "pmon.add" }
    })

    button_flow.add({
        type = "button",
        style = "pmon_button_default",
        name = "pmon_add_cancel_button",
        caption = { "pmon.cancel" }
    })
end

function pmon.get_add_dialog(player)
    local gui = player.gui.center
    if gui.pmon_add_dialog then
        return gui.pmon_add_dialog
    else
        return nil
    end
end

function pmon.on_player_selected_area(event)
    player = game.players[event.player_index]

    if player.cursor_stack.name == "pmon-power-monitor" then
        player.clean_cursor()
        pmon.create_add_dialog(player, event.entities[1])
    end
end