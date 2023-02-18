extends Area2D
class_name Bullet

signal hit(hit_info: HitInfo)

@export var damage_source: DamageSource
@export var visible_area: VisibleArea

var velocity: Vector2 = Vector2.RIGHT
var has_hit: bool = false
#static func from_direction(position: Vector2, speed: float, direction: float) -> Bullet:
#	return Bullet.new(position, Vector2.UP.rotated(deg_to_rad(direction)))

#static func 

func place(pos: Vector2) -> Bullet:
	position = pos
	return self

func setup( init_velocity, team, pre_render: float = 0) -> Bullet:
	position = position + init_velocity * pre_render
	velocity = init_velocity
	ST.setup_collisions(self, team, true)
	return self

func _ready():
	assert(damage_source, "No damage source created")

func _physics_process(delta):
	position += velocity * delta
	if not visible_area.is_visible(position):
		queue_free()

func _on_body_entered(__other: CollisionObject2D):
	if has_hit:
		return
	
	if __other.has_method("be_hurt_by"):
		has_hit = true
		var hit_info: HitInfo = HitInfo.new()
		__other.be_hurt_by(damage_source, hit_info)
		if __other.has_method("apply_knockback"):
			__other.apply_knockback(velocity * damage_source.knockback_multiplier, self)
		hit.emit(hit_info)
		queue_free()


func done():
	queue_free()
