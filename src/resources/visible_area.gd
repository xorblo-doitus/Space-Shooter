@tool
extends Resource
class_name VisibleArea


@export var size: Vector2 = Vector2(5, 5):
	set(new):
		size = new
		@warning_ignore("narrowing_conversion")
		up = -new.y/2
		down = new.y/2 + ST.get_screen_height()
		right = new.x/2 + ST.get_screen_width()
		@warning_ignore("narrowing_conversion")
		left = -new.x/2
		prints("Set VisibleArea's size to", new, "resulting to up", up, "down", down, "right", right, "left", left)
var up: int
var down: int
var right: int
var left: int


#func get_up_right_corner() -> Vector2:
#	return -size/2
#func get_down_left_corner() -> Vector2:
#	return size/2 + Vector2(ST.get_screen_width(), ST.get_screen_height())

func is_visible(position: Vector2) -> bool:
	return position.x > left and position.x < right and position.y > up and position.y < down
