extends Vessel
class_name PlayerVessel

const kill_combo_added: float = 0.1
const combo_on_hurted_decrease: float = 1.5

signal score_changed(new_score: float)
signal combo_changed(new_combo: float)

var score: float = 0:
	set(new):
		if new != score:
			score = new
			score_changed.emit(new)
var combo: float = 1:
	set(new):
		if new != combo:
			combo = new
			combo_changed.emit(new)

func _ready() -> void:
	set_flip(false)
	super()

func _physics_process(delta) -> void:
#	health = max_health
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	firing = Input.is_action_pressed("ui_accept")
	super(delta)


func on_hit(hit: HitInfo) -> void:
	score += combo * (hit.damage_dealt + hit.bonus_score)
	combo += hit.bonus_combo + (kill_combo_added if hit.fatal else 0.)


func bind_bullet(bullet: Bullet) -> void:
	bullet.hit.connect(on_hit)


func be_hurt_by(damage_source: DamageSource, hit_info: HitInfo = HitInfo.new()) -> HitInfo:
	if combo >= combo_on_hurted_decrease:
		combo /= combo_on_hurted_decrease
	elif combo >= 1:
		combo = 1
	return super(damage_source, hit_info)


func install_weapon(new_weapon: Weapon) -> void:
	new_weapon.flip()
	new_weapon.fire.connect(bind_bullet)
	super(new_weapon)
