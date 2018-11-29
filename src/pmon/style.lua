local default_gui = data.raw["gui-style"].default

data:extend({
    {
        type = "font",
        name = "pmon_font_default",
        from = "default",
        size = 14
    },
})

default_gui["pmon_button_default"] = {
    type = "button_style",
    font = "pmon_font_default",
    align = "center",
    vertical_align = "center"
}

default_gui["pmon_sprite_button_default"] = {
    type = "button_style",
    parent = "icon_button",
    font = "pmon_font_default",
    align = "center",
    vertical_align = "center",
    height = 36
}

default_gui["pmon_label_default"] = {
    type = "label_style",
    font = "pmon_font_default",
    minimal_width = 150
}

default_gui["pmon_textfield_default"] = {
    type = "textfield_style",
    font = "pmon_font_default",
    minimal_width = 300
}
