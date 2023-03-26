@tool
extends Spawner
class_name SpawnGroup

const line_color: Color = Color(1, 1, 0, 0.3)

## Spawners of this group automatically found in childrens, sorted by descending weight
var spawners: Array[Spawner]
var spawners_weight: float = 0.

func _ready():
	for child in get_children():
		if child is Spawner:
			spawners.append(child)
			
	spawners.sort_custom(
		func(a: Spawner, b: Spawner):
			return a.get_weight() < b.get_weight()
	)
	
	for spawner in spawners:
		spawners_weight += spawner.get_weight()
		spawner.spawned.connect(redirect_spawned_event)
		spawner.warn.connect(redirect_warn_event)


func redirect_spawned_event(new_vessel: Vessel):
	spawned.emit(new_vessel)
func redirect_warn_event(new_popup: WarningPopup):
	warn.emit(new_popup)

## Return the weight of this spawner, usefull for SpawnGroup weighted random choice
func get_weight() -> float:
	return weight_coef * spawners_weight


func spawn() -> Entity:
	var num_choosed: float = randf() * spawners_weight
	
	for spawner in spawners:
		num_choosed -= spawner.get_weight()
		if num_choosed <= 0:
#			@warning_ignore("redundant_await")
			return await spawner.spawn()
	
	# Just in case
#	@warning_ignore("redundant_await")
	return await spawners[-1].spawn()


func _draw():
	for spawner in spawners:
		draw_line(spawner.position, Vector2.ZERO, line_color)





