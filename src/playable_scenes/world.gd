extends Node2D
class_name World

@onready var vessels = $Vessels
@onready var bullets = $Bullets

func _ready():
	for spawn_point in $SpawnPoints.get_children():
		vessels.add_child(spawn_point.vessel.instantiate().place(spawn_point.global_position))
	
	for vessel in vessels.get_children():
		vessel.connect("weapon_equiped", add_weapon)
		for weapon in vessel.get_installed_weapons():
			add_weapon(weapon)

func add_weapon(weapon: Weapon) -> void:
	weapon.connect("fire", add_bullet)

func add_bullet(bullet: Bullet) -> void:
	bullets.add_child(bullet)
