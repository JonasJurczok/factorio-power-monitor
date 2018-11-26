pmon = {}

function pmon.mod_init()

end

function pmon.on_tick(event)
    if (event.tick % 10 == 0) then
        event.player.print("Energy: " .. player.selected.energy .. "J" )
    end
end