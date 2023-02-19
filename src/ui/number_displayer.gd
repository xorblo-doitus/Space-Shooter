extends Label
class_name NumberDisplayer

## display a number

## Emited whenever the number has changed enough compared to the `precision` attribute to make it visually change
signal visually_changed(visual_gain: float)

@export var precision: float = 1
@export var format_string: StringName = "%d"

var number: float = 0:
	set(new_number):
		if new_number != number:
			update_number(new_number - number)
			number = new_number
			update_text()


func get_formated_number() -> String:
	return format_string % snappedf(number, precision)


func update_text() -> void:
	text = get_formated_number()


var unregistered_gain: float = 0

func update_number(gain: float) -> void:
	unregistered_gain += gain
	if unregistered_gain > 1:
		# get full gain
		gain = unregistered_gain
		unregistered_gain = fmod(unregistered_gain, precision)
		# Substract remainder wich is not truely displayed
		gain -= unregistered_gain
		
		visually_changed.emit(gain)
		




