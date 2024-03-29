extends Marker2D
class_name Spawner

## A virtual class for creating spawners

## emitted when a new vessel is spawned
signal spawned(new_vessel: Vessel)
signal warn(popup: WarningPopup)

@export_range(0, 10, 0.01, "or_greater", "suffix:*") var weight_coef: float = 1

func spawn() -> Entity:
	@warning_ignore("assert_always_false")
	assert(false, "virtual method not implemented")
	@warning_ignore("redundant_await")
	await 0
	return


#func setup_new_vessel(new_vessel: Vessel) -> Vessel:
#	new_vessel.place(choose_position())
#	spawned.emit(new_vessel)
#	return new_vessel


## Return the weight of this spawner, usefull for SpawnGroup weighted random choice
func get_weight() -> float:
	return weight_coef


## Choose a position accordingly to the spawner class[br]
func choose_position() -> Vector2:
	@warning_ignore("assert_always_false")
	assert(false, "virtual method not implemented")
	return global_position
