extends Vessel

func _ready() -> void:
	$Pivot.scale.x = -1
	super._ready()

func _physics_process(delta) -> void:
	health = max_health
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	firing = Input.is_action_pressed("ui_accept")
	super._physics_process(delta)


func install_weapon(new_weapon: Weapon) -> void:
	new_weapon.flip()
	super.install_weapon(new_weapon)
