@tool
extends Spawner
class_name SpawnPoint

## A point spawning an enemy, can do it multiple times

const warning_popup := preload("res://src/ui/warning_popup.tscn")

@export var entity_info: EntityInfo
#@export_range(0, 10, 0.01, "or_greater", "suffix:*") var weight_coef: float = 1

## Choose a position accordingly to the spawner class[br]
##  - Return this spawner pos
func choose_position() -> Vector2:
	return global_position

func _ready():
	assert(entity_info, "No entity to spawn was given to " + str(get_path()))

### Return the weight of this spawner, usefull for SpawnGroup weighted random choice
#func get_weight() -> float:
#	return weight_coef


func spawn() -> Entity:
	var new_vessel = entity_info.new().place(choose_position())
	if entity_info.get_spawn_time():
		var new_popup = warning_popup.instantiate().setup(new_vessel.global_position)
		warn.emit(new_popup)
		await Wait.secondes(entity_info.get_spawn_time())
		new_popup.queue_free()
	spawned.emit(new_vessel)
	return new_vessel
