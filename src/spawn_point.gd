@tool
extends Marker2D
class_name SpawnPoint

## A point spawning an enemy, can do it multiple times

const area_color = Color(1, 0, 0, 0.3)

signal spawned(new_vessel: Vessel)

@export var packed_vessel := preload("res://src/vessels/dude_vessel.tscn")
@export var area: Vector2i = Vector2i.ZERO:
	set(new):
		area = new
		queue_redraw()

func spawn() -> Vessel:
	var new_vessel: Vessel = packed_vessel.instantiate().place(global_position + Vector2((randf()-.5) * area.x, (randf()-.5) * area.y))
	spawned.emit(new_vessel)
	return new_vessel


func _draw() -> void:
	if area:
		draw_rect(Rect2i(-area/2, area), area_color, false, 10)
