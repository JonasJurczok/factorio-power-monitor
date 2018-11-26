pmon = {}

function pmon.mod_init()

end

function pmon.on_tick(event)
    if (event.tick % 10 == 0) then
        for _, player in pairs(game.players) do
            if (player.selected) then

                player.print("Energy: " .. player.selected.energy .. "J" )
            end
        end
    end
end