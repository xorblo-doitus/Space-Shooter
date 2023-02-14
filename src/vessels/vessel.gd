extends CharacterBody2D
class_name Vessel

signal fire(bullet: Bullet)

const KNOCKBACK_HISTORY: int = 5
const DAMAGE_BLINK_DECAY_SPEED: float = 3
const DAMAGE_BLINK_DIVIDING: int = 74
const DAMAGE_BLINK_EXPONENT: float = 1.4

@export var team: ST.TEAM = ST.TEAM.Enemy
@export_range(1, 1000, 1, "or_greater", "suffix:❤") var max_health: float = 100
@export_range(0, 1000, 0.1, "or_greater", "suffix:p/s") var speed: float = 400
@export_range(100, 1000, 1, "or_less", "or_greater", "suffix:p/s") var acceleration_speed: float = 2000
@export var bullet_type := preload("res://src/bullets/basic_bullet.tscn")
@export_range(0, 10, 0.1, "or_greater", "suffix:p/s") var air_friction: float = 4
@export var firing: bool = false
@export var direction := Vector2.ZERO
@export_range(0, 2000, 1, "or_less", "or_greater", "suffix:p/s") var knockback_dealed: float = 500
@export_range(0, 5, 0.01, "or_greater", "suffix:*") var knockback_weakness: float = 1
@export var default_weapon := preload("res://src/weapons/basic_gun.tscn")


@onready var canon = $Pivot/Canon
@onready var collision_shape_2d = $CollisionShape2D

#@onready var animator = $Animator

#var min_velocity := Vector2(-speed, -speed)
#var max_velocity := Vector2(speed, speed)
var health: float = max_health
var recently_knocked: Array = [] # Array of array
var knockback_to_apply: Array[KnockBack] = []
var damage_hint: float = 0
var weapon: Weapon

func _ready():
	health = max_health
	equip_weapon(default_weapon.instantiate())
	canon.add_child(weapon)
	
	for __ in KNOCKBACK_HISTORY:
		recently_knocked.append([])
	
#	platform_floor_layers = 0
	
	ST.setup_collisions(self, team)
	
#	momentum = min(speed, momentum)

func _process(delta):
	collision_shape_2d.debug_color = Color(damage_hint, damage_hint-1, 1-damage_hint if damage_hint < 2 else damage_hint-2, 0.41)
	damage_hint = move_toward(damage_hint, 0, delta * DAMAGE_BLINK_DECAY_SPEED)
	

func _physics_process(delta):
	if direction:
#		velocity += direction.normalized() * speed
#		velocity = velocity.clamp(min_velocity, max_velocity)
		var movement = direction.normalized() * speed
		velocity.x = move_toward(velocity.x, movement.x, acceleration_speed * delta)
		velocity.y = move_toward(velocity.y, movement.y, acceleration_speed * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * air_friction * delta)
		velocity.y = move_toward(velocity.y, 0, speed * air_friction * delta)
	
	
	recently_knocked.pop_front()
	var this_frame_knocked := []
	recently_knocked.append(this_frame_knocked)
	for knockback in knockback_to_apply:
		if was_recently_knocked(knockback.from):
			continue
		if name == "PlayerVessel":
			pass
		this_frame_knocked.append(knockback.from)
		velocity += knockback.force
	knockback_to_apply.clear()
	
	move_and_slide()
	
	for slide_num in get_slide_collision_count():
		var collision = get_slide_collision(slide_num)
		var __other = collision.get_collider()
		if __other.is_class("StaticBody2D"):
			velocity = velocity.slide(collision.get_normal())
			continue
		
		if was_recently_knocked(__other):
			continue
		
		if __other.has_method("apply_knockback"):
			__other.apply_knockback(collision.get_normal() * -knockback_dealed, self)
		if __other.has_method("get_knockback_dealed"):
			apply_knockback(collision.get_normal() * __other.get_knockback_dealed(), __other)
	
	
	for bullet in weapon.update(delta, firing, velocity):
		emit_signal(
			"fire",
			bullet
		)
	velocity += weapon.recoil_last_frame
#	reloading -= 1 * delta
#
#	if firing:
#		if reloading <= 0:
#			for __ in range(-floor(reloading/reload_time)): # round toward -inf
#				velocity += Vector2(-recoil, 0).rotated(deg_to_rad(shot_direction))
#				emit_signal(
#					"fire",
#					weapon.get_bullet().setup(velocity/ST.velocity_kept + Vector2(800, 0).rotated(deg_to_rad(shot_direction)), team, -reloading)
#				)
#				reloading = reloading + reload_time
#	else:
#		reloading = max(reloading, 0)

func was_recently_knocked(__other) -> bool:
	for frame in recently_knocked:
		if __other in frame:
			return true
	return false

func get_knockback_dealed() -> float:
	return knockback_dealed

func apply_knockback(knockback: Vector2, from: Object):
	knockback_to_apply.append(KnockBack.new(knockback, from))

func place(pos: Vector2) -> Vessel:
	position = pos
	return self

func be_hurt_by(damage_source: DamageSource):
	health -= damage_source.damage
	if health <= 0:
		queue_free()
	else:
#		animator.play("hurted")s
		damage_hint = clamp(damage_hint + pow(damage_source.damage/DAMAGE_BLINK_DIVIDING, DAMAGE_BLINK_EXPONENT) + 0.3, 0, 3)

func equip_weapon(new_weapon: Weapon) -> void:
	new_weapon.team = team
	weapon = new_weapon
