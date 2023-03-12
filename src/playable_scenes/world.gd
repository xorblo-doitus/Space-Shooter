extends Node2D
class_name World

@onready var vessels = $Vessels
@onready var bullets = $Bullets

func _ready():
	for spawner in $Spawners.get_children():
		add_spawner(spawner)
	
#	var player = 
	get_tree().call_group("ScoreDisplayer", "bind_player", await $Spawners/Player.spawn())
#	$UI/MarginContainer/VBoxContainer/ScoreDisplayer.bind_player(
#		$Spawners/Player.spawn()
#	)

	
#	for vessel in vessels.get_children(): 
#		add_vessel(vessel)
	
	$AnimationPlayer.play("test_level")

func add_spawner(spawner: Spawner) -> void:
	spawner.spawned.connect(add_vessel)

func add_vessel(vessel: Vessel) -> void:
	vessel.weapon_equiped.connect(add_weapon)
	for weapon in vessel.get_installed_weapons():
		add_weapon(weapon)
	vessels.add_child(vessel)

func add_weapon(weapon: Weapon) -> void:
	weapon.fire.connect(add_bullet)

func add_bullet(bullet: Bullet) -> void:
	bullets.add_child(bullet)


func get_spawners() -> Array[Spawner]:
	var spawners: Array[Spawner] = []
	for child in $Spawners.get_children():
		if child is Spawner:
			spawners.append(child)
	return spawners

func _on_animation_player_animation_finished(_anim_name):
	$AnimationPlayer.play("test_level")
