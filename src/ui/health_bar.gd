extends ProgressBar
class_name HealthBar

const text_format: StringName = "%d/%d"
const non_full_alpha: float = 0.3

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
@onready var disappear_timer = $DisappearTimer
@onready var label = $Label


func _ready():
	hide()
	style_box.bg_color = Color(0, 0, 0)
	add_theme_stylebox_override("fill", style_box)
	update()


func setup(init_health: float, init_max_health: float) -> HealthBar:
	target_value = init_health
	max_health = init_max_health
	hide()
	return self


static func set_color_from_percent(color: Color, percent: float) -> Color:
#	color.r = 3-percent*3
#	color.g = percent*3
	color = Color.GREEN
	return color

func stop_blink() -> void:
	blink = false

func update() -> void:
	value = target_value
	label.text = text_format % [ceili(target_value), max_health]
	update_color()
	modulate.a = 1
	show()
	trigger_chrono_fade_out()


func trigger_chrono_fade_out() -> void:
	disappear_timer.start()


func start_fade_out() -> void:
	set_process(true)


func _process(delta):
	if target_value == max_health:
		modulate.a = move_toward(modulate.a, 0, delta*disappear_speed)
		if modulate.a == 0:
			hide()
			set_process(false)
	else:
		modulate.a = move_toward(modulate.a, non_full_alpha, delta*disappear_speed)
		if modulate.a == non_full_alpha:
			set_process(false)

func update_color() -> void:
	if blink:
		style_box.bg_color = Color.WHITE
	else:
		style_box.bg_color = HealthBar.set_color_from_percent(Color.BLACK, value/max_value)


