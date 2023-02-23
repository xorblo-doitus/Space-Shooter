@tool
extends SpawnPoint
class_name SpawnArea

## Spawn a vessel randomly inside the defined area

const area_color = Color(1, 0, 0, 0.3)

@export var area: Vector2i = Vector2i.ZERO:
	set(new):
		new.x = cap_area_axe(new.x)
		new.y = cap_area_axe(new.y)
		area = new
		queue_redraw()

## Prevent a 0 or negative axe
func cap_area_axe(a) -> int:
	return maxi(1, absi(a))

#func _ready():
#	print(get_weight())

## Choose a position accordingly to the spawner class[br]
##  - Return a random pos in the defined area
func choose_position() -> Vector2:
	return global_position + Vector2((randf()-.5) * area.x, (randf()-.5) * area.y)


#func spawn() -> Vessel:
#	var new_vessel: Vessel = packed_vessel.instantiate().place(global_position + Vector2((randf()-.5) * area.x, (randf()-.5) * area.y))
#	spawned.emit(new_vessel)
#	return new_vessel

## Return the weight of this spawner, usefull for SpawnGroup weighted random choice
func get_weight() -> float:
	return weight_coef * area.x * area.y

func _draw() -> void:
	# TODOGODOT4:bool Wait for the boolean operator fix
	if Engine.is_editor_hint():
		if area:
			draw_rect(Rect2i(-area/2, area), area_color, false, 5)
