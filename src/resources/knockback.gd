extends Object
class_name KnockBack

var force: Vector2 = Vector2.ZERO
var from: Object

func _init(init_force: Vector2, init_from: Object):
	force = init_force
	from = init_from
