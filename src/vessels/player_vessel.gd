extends Vessel

signal score_changed(new_score: float)

var score: float = 0:
	set(new):
		if new != score:
			score = new
			score_changed.emit(new)

func _ready() -> void:
	$Pivot.scale.x = -1
	super()

func _physics_process(delta) -> void:
#	health = max_health
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	firing = Input.is_action_pressed("ui_accept")
	super(delta)


func on_hit(hit: HitInfo) -> void:
	score += hit.damage_dealt + hit.bonus_score


func bind_bullet(bullet: Bullet) -> void:
	bullet.hit.connect(on_hit)


func install_weapon(new_weapon: Weapon) -> void:
	new_weapon.flip()
	new_weapon.fire.connect(bind_bullet)
	super(new_weapon)
