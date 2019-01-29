local technology = {
    type = "technology",
    name = "pmon-power-monitoring",
    icon = "__core__/graphics/electricity-icon-red.png",
    icon_size = 64,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "pmon-power-monitor"
        }
    },
    prerequisites = { "electric-energy-accumulators-1" },
    unit = table.deepcopy(data.raw.technology['electric-energy-accumulators-1'].unit),
    order = table.deepcopy(data.raw.technology['electric-energy-accumulators-1'].order),
}
technology.unit.count = technology.unit.count * 3

local recipe = {
    type = "recipe",
    name = "pmon-power-monitor",
    enabled = false, --this one may be set to TRUE to make recipe available from the start
    ingredients ={
        {'steel-plate', 2}, {'iron-plate', 1},
        {'electronic-circuit', 2}, {'copper-cable', 40},
        {'red-wire', 26}, {'green-wire', 26},
    },
    result = "pmon-power-monitor"
}

local item = {
    type = "selection-tool",
    name = "pmon-power-monitor",
    icon = "__core__/graphics/electricity-icon-red.png",
    icon_size = 64,
    flags = {"goes-to-quickbar"},
    subgroup = "tool",
    damage_radius = 5,
    order = "zz",
    stack_size = 1,
    selection_color = { r = 0, g = 1, b = 0 },
    alt_selection_color = { r = 0, g = 1, b = 0 },
    selection_mode = {"blueprint"},
    alt_selection_mode = {"blueprint"},
    selection_cursor_box_type = "copy",
    alt_selection_cursor_box_type = "copy"
}

data:extend({technology, recipe, item})