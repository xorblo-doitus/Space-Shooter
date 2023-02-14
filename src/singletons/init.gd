extends Node

func _ready():
	if OS.is_debug_build():
		var window = get_window()
		window.always_on_top = true
		window.size = Vector2i(640, 360)
		window.position = Vector2i(700, 350)
#		ProjectSettings.set_setting("display/window/size/always_on_top", true)
#		ProjectSettings.set_setting("display/window/size/window_width_override", 640)
#		ProjectSettings.set_setting("display/window/size/window_height_override", 360)
