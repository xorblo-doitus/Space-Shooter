@tool
extends Node2D
class_name PopupManager

@export var draw_debug_lines: bool = false:
	set(new):
		draw_debug_lines = new
		queue_redraw()

func add_popup(popup: WarningPopup) -> WarningPopup:
	%Popups.add_child(popup)
	popup.position = %PopupPath.curve.get_closest_point(popup.target_pos)
	popup.update_arrow.call_deferred()
	print(popup.position, " buuuut ", popup.global_position)
	popup.get_node("ArrowPivot").look_at(popup.target_pos)
	return popup


func clear() -> void:
	for popup in %Popups.get_children():
		popup.queue_free()


func _draw():
	if Engine.is_editor_hint() and draw_debug_lines:
		print(global_position)
		clear()
		var packed_popup = load("res://src/ui/warning_popup.tscn")
		for y in [-100, ST.get_screen_height() + 100]:
			for x in range(-100, ST.get_screen_width() + 100, 100):
				draw_line(Vector2(x, y), %PopupPath.curve.get_closest_point(Vector2(x, y)), Color.DEEP_SKY_BLUE)
				add_popup(packed_popup.instantiate().setup(Vector2(x, y)))
		for x in [-100, ST.get_screen_width() + 100]:
			for y in range(-100, ST.get_screen_height() + 100, 100):
				draw_line(Vector2(x, y), %PopupPath.curve.get_closest_point(Vector2(x, y)), Color.DEEP_SKY_BLUE)
				add_popup(packed_popup.instantiate().setup(Vector2(x, y)))
