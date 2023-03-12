@tool
extends Path2D

signal modified

@export var margin: int = 32: 
	set(new):
		margin = new
		update()
@export var corner_radius: int = 32:
	set(new):
		corner_radius = new
		update()


func _ready():
	update()


func update() -> void:
	for point in curve.point_count:
		curve.set_point_in(point, Vector2i.ZERO)
		curve.set_point_out(point, Vector2i.ZERO)
	
	# Top left corner
	curve.set_point_position(0, Vector2i(margin, margin + corner_radius))
	curve.set_point_out(0, Vector2i(0, -corner_radius))
	
	curve.set_point_position(1, Vector2i(margin + corner_radius, margin))
	
	# Top right corner
	curve.set_point_position(2, Vector2i(ST.get_screen_width() - margin - corner_radius, margin))
	curve.set_point_out(2, Vector2i(corner_radius, 0))
	
	curve.set_point_position(3, Vector2i(ST.get_screen_width() - margin, margin + corner_radius))
	
	# Bottom right corner
	curve.set_point_position(4, Vector2i(
		ST.get_screen_width() - margin,
		ST.get_screen_height() - margin - corner_radius
	))
	curve.set_point_out(4, Vector2i(0, corner_radius))
	
	curve.set_point_position(5, Vector2i(
		ST.get_screen_width() - margin - corner_radius,
		ST.get_screen_height() - margin
	))
	
	# Bottom left corner
	curve.set_point_position(6, Vector2i(margin + corner_radius, ST.get_screen_height() - margin))
	curve.set_point_out(6, Vector2i(-corner_radius, 0))
	
	curve.set_point_position(7, Vector2i(margin, ST.get_screen_height() - margin - corner_radius))
	
	curve.set_point_position(curve.point_count - 1, curve.get_point_position(0))
	
	modified.emit()
