@tool
extends Spawner
class_name SpawnPoint

## A point spawning an enemy, can do it multiple times


@export var packed_vessel := preload("res://src/vessels/dude_vessel.tscn")
#@export_range(0, 10, 0.01, "or_greater", "suffix:*") var weight_coef: float = 1

## Choose a position accordingly to the spawner class[br]
##  - Return this spawner pos
func choose_position() -> Vector2:
	return global_position

### Return the weight of this spawner, usefull for SpawnGroup weighted random choice
#func get_weight() -> float:
#	return weight_coef


func spawn() -> Vessel:
	return setup_new_vessel(packed_vessel.instantiate())
