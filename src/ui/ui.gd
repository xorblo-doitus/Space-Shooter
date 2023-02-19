@tool
extends Control


## Simply set the size to the whole screen size
func _ready():
	custom_minimum_size = Vector2(ST.get_screen_width(), ST.get_screen_height())
