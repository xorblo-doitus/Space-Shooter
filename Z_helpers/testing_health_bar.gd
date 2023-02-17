@tool
extends HealthBar


@export_range(0, 100, 0.5, "suffix:♥") var testing_health: float = 75:
	set(new):
		testing_health = new
		target_value = new
		update()

## Trying to change this value will update the gradient, not meant to be really set to true
@export var manually_update_gradient: bool = false:
	set(_new):
		manually_update_gradient = false
		update_gradient()

@onready var bit: ColorRect = $Bit
@onready var gradient = $Gradient

func  _ready():
	super()
	update_gradient()


func update_gradient():
	print("updating gradient...")
	for child in gradient.get_children():
		child.queue_free()
	for x in 100:
		var percent: float = x/100.
		var new = bit.duplicate()
		new.position.x += x
		new.color = HealthBar.set_color_from_percent(Color(0, 0, 0), percent)
		new.show()
		gradient.add_child(new)
