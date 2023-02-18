extends Node2D
class_name World

@onready var vessels = $Vessels
@onready var bullets = $Bullets

func _ready():
	for spawn_point in $SpawnPoints.get_children():
		add_spawn_point(spawn_point)
	
	$SpawnPoints/Player.spawn()

	
#	for vessel in vessels.get_children(): 
#		add_vessel(vessel)
	
	$AnimationPlayer.play("test_level")

func add_spawn_point(spawn_point: SpawnPoint) -> void:
	spawn_point.spawned.connect(add_vessel)

func add_vessel(vessel: Vessel) -> void:
	vessel.weapon_equiped.connect(add_weapon)
	for weapon in vessel.get_installed_weapons():
		add_weapon(weapon)
	vessels.add_child(vessel)

func add_weapon(weapon: Weapon) -> void:
	weapon.fire.connect(add_bullet)

func add_bullet(bullet: Bullet) -> void:
	bullets.add_child(bullet)


func _on_animation_player_animation_finished(_anim_name):
	$AnimationPlayer.play("test_level")
