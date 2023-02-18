extends Weapon

## A null weapon, wich act as if the vessel had no weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	set_process(false)

func update(_delta: float, _firing: bool, _implied_velocity: Vector2) -> Vector2:
	return Vector2.ZERO

func place(pos: Vector2) -> Weapon:
	return self

func flip() -> void:
	pass
