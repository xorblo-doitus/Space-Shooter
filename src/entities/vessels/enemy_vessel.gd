extends Vessel
class_name EnemyVessel

## The base script for enemies

## The distance in pixel the enemy will despawn when leaving on the LEFT side of the screen.
@export_range(0, 100, 1, "show_slider", "or_greater", "suffix:px") var despawn_distance: int = 0:
	set(new):
		despawn_distance = -abs(new)


func _ready():
	assert(despawn_distance, "Despawn distance has not been set on " + name)
	set_flip(true)
	super()
	


func _physics_process(delta):
	super(delta)
	if position.x < despawn_distance:
		despawn()


func despawn() -> void:
	queue_free()
