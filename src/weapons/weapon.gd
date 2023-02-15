extends Node2D
class_name Weapon

signal fire(bullet: Bullet)

const empty_bullet_array: Array[Bullet] = []

@onready var appear_point = $AppearPoint

@export var bullet := preload("res://src/bullets/basic_bullet.tscn")
@export_range(0, 60, 0.001, "or_greater", "suffix:s") var reload_time: float = 0.5
@export_range(0, 1000, 1, "or_less", "or_greater", "suffix:p/s") var recoil: float = 400
@export_range(0, 3000, 0.1, "or_greater", "suffix:p/s") var shot_speed: float = 800
@export_range(-360, 360, 0.1, "or_less", "or_greater", "suffix:°") var shot_direction: float = -180
@export_range(0, 360, 0.1, "or_greater", "suffix:°") var dispersion_angle: float = 0
@export_range(0, 5, 0.01, "or_greater") var dispersion_chance: float = 0.2
@export_range(0, 1, 0.01, "suffix:*") var velocity_kept: float = 0.16

var team: ST.TEAM = ST.TEAM.Enemy
var reloading: float = 0.0

func update(delta: float, firing: bool, implied_velocity: Vector2) -> Vector2:
	reloading -= 1 * delta
	if firing:
		if reloading <= 0:
			var recoil_this_frame: Vector2 = Vector2.ZERO
			for __ in range(-floor(reloading/reload_time)): # round toward -inf
				var this_direction := shot_direction
				if dispersion_angle:
					this_direction += dispersion_angle * (randfn(0.5, dispersion_chance) - 0.5)
				recoil_this_frame += Vector2(-recoil, 0).rotated(deg_to_rad(this_direction))
				fire.emit(
					bullet.instantiate()
						.place(appear_point.global_position)
						.setup(implied_velocity*velocity_kept + Vector2(shot_speed, 0).rotated(deg_to_rad(this_direction)), team, -reloading)
				)
				reloading = reloading + reload_time
			return recoil_this_frame
	else:
		reloading = max(reloading, 0)
	return Vector2.ZERO

func place(pos: Vector2) -> Weapon:
	position = pos
	return self

func flip() -> void:
	shot_direction += 180
