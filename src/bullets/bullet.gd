extends Area2D
class_name Bullet

@export var damage_source: DamageSource
@export var visible_area: VisibleArea

var velocity: Vector2 = Vector2.RIGHT

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
	if __other.has_method("be_hurt_by"):
		__other.be_hurt_by(damage_source)
		if __other.has_method("be_hurt_by"):
			__other.apply_knockback(velocity * damage_source.knockback_multiplier, self)
		queue_free()


func done():
	queue_free()
