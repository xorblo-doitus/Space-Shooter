extends Marker2D

## A little script to follow the path

## The speed at wich the center moves toward the target
@export_range(0, 1000, 0.1, "or_greater", "suffix:px/s") var base_follow_speed = 20
@export_range(0, 20, 0.01, "or_greater", "suffix:*") var follow_speed_multiplier = 5

var last_position: Vector2
func _ready():
	last_position = global_position
	%CenterTarget.global_position = last_position

func _physics_process(delta):
	last_position = last_position.move_toward(
		%CenterTarget.global_position,
		(last_position.distance_to(%CenterTarget.global_position) + base_follow_speed) * delta * follow_speed_multiplier
	)
	global_position = last_position
	%TracktorBeam.target_pos = position
