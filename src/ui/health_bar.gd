extends ProgressBar
class_name HealthBar

@export_range(0, 10) var disappear_speed: float = 0.5

var target_value: float = 75:
	set(new):
		if new != target_value:
			target_value = new
			update()
var blink: bool = false:
	set(new):
		if blink != new:
			blink = new
			update_color()
		if blink:
			blink_timer.start()
var max_health: float = 100:
	set(new):
		max_health = new
		max_value = new
		update()

var style_box: StyleBox = get_theme_stylebox("fill").duplicate()

@onready var blink_timer = $BlinkTimer

func _ready():
	style_box.bg_color = Color(0, 0, 0)
	add_theme_stylebox_override("fill", style_box)
	update()

static func set_color_from_percent(color: Color, percent: float) -> Color:
	color.r = 3-percent*3
	color.g = percent*3
	return color

func stop_blink() -> void:
	blink = false

func update() -> void:
	value = target_value
	update_color()
	if target_value == max_health:
		set_process(true)

func _process(delta):
	if target_value == max_health:
		modulate.a = move_toward(modulate.a, 0, delta*disappear_speed)
	else:
		modulate.a = 1
		set_process(false)

func update_color() -> void:
	if blink:
		style_box.bg_color = Color.WHITE
	else:
		style_box.bg_color = HealthBar.set_color_from_percent(Color.BLACK, value/max_value)


