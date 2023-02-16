extends Node

var fullscreen: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		fullscreen = not fullscreen
		print("set fullscreen to ", fullscreen)
		if fullscreen:
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
