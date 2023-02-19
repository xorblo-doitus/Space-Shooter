extends Marker2D
class_name SpawnPoint

## A point spawning an enemy, can do it multiple times

signal spawned(new_vessel: Vessel)

@export var packed_vessel := preload("res://src/vessels/dude_vessel.tscn")

func spawn() -> Vessel:
	var new_vessel: Vessel = packed_vessel.instantiate().place(global_position)
	spawned.emit(new_vessel)
	return new_vessel
