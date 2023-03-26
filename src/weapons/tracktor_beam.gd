extends Line2D

@onready var path_2d: Path2D = $Path2D

@export var curving: float = 10:
	set(new):
		curving = new
		(func(): path_2d.curve.set_point_out(0, Vector2(new, 0))).call_deferred()
@export var target_pos: Vector2 = Vector2(50, 0):
	set(new):
		target_pos = new
		update()

func update() -> void:
	path_2d.curve.set_point_position(1, target_pos)
	clear_points()
	for point in path_2d.curve.get_baked_points():
		add_point(point)
