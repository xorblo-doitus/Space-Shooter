extends Node2D
class_name Weapon

signal fire(bullet: Bullet)

const empty_bullet_array: Array[Bullet] = []

@onready var appear_point = %AppearPoint

@export var bullet := preload("res://src/bullets/basic_bullet.tscn")
@export_range(0, 60, 0.001, "or_greater", "suffix:s") var reload_time: float = 0.5
@export_range(0, 1000, 1, "or_less", "or_greater", "suffix:p/s") var recoil: float = 400
@export_range(0, 3000, 0.1, "or_greater", "suffix:p/s") var shot_speed: float = 800
@export_range(-360, 360, 0.1, "or_less", "or_greater", "suffix:°") var shot_direction: float = -180
@export_range(0, 360, 0.1, "or_greater", "suffix:°") var dispersion_angle: float = 0
@export_range(0, 5, 0.01, "or_greater") var dispersion_chance: float = 0.2
@export_range(0, 1, 0.01, "suffix:*") var velocity_kept: float = 0.3

@export_group("Style")
@export var brightness_mapper: ShaderMaterial = load("res://src/shadering/materials/brightness_mapper.tres")
@export var brightnessable: Array[NodePath] = []
@export_subgroup("Animation", "animation_")
@export_range(0, 20, 0.01, "or_greater", "suffix:*") var animation_speed: float = 3.0
@export var animation_speed_curve: Curve = Curve.new()

var team: ST.TEAM = ST.TEAM.Enemy
var reloading: float = 0.0


func _ready():
	brightness_mapper = brightness_mapper.duplicate()
	for path in brightnessable:
		get_node(path).material = brightness_mapper
	%Animator.play("rotate")


## Whether or not this weapon has reloaded this frame. (But not Whether or not this is currently reloaded)
var reloaded_this_frame: bool = false
func update(delta: float, firing: bool, implied_velocity: Vector2) -> Vector2:
	if reloading > 0:
		reloading -= 1 * delta
		if reloading <= 0:
			reloaded_this_frame = true
		else:
			reloaded_this_frame = false
	else:
		reloading -= 1 * delta
		reloaded_this_frame = false
	
	
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
			
			update_animation()
			return recoil_this_frame
	else:
		if reloading:
			reloading = max(reloading, 0)
	
	update_animation()
	
	return Vector2.ZERO

func update_animation() -> void:
	%Animator.speed_scale = animation_speed_curve.sample(1 - (reloading / reload_time)) * animation_speed
#	brightness_mapper.set_shader_parameter("amount", 1)
	if reloaded_this_frame:
		brightness_mapper.set_shader_parameter("amount", 1)
	elif reloading:
		brightness_mapper.set_shader_parameter("amount", 0)
	else:
		brightness_mapper.set_shader_parameter("amount", 0.1)
#		pass
#		brightness_mapper.set_shader_parameter("amount", move_toward(brightness_mapper.get_shader_parameter("amount"), ))
#		brightness_mapper.set_shader_parameter("amount", move_toward(brightness_mapper.get_shader_parameter("amount"), 0, delta/10))

func place(pos: Vector2) -> Weapon:
	position = pos
	return self

func flip() -> void:
	shot_direction += 180
