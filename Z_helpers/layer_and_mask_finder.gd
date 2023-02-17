@tool
extends Node2D


@export_flags_2d_physics var player_layers: int:
	set(new):
		player_layers = new
		update()
@export_flags_2d_physics var player_mask: int:
	set(new):
		player_mask = new
		update()
@export_flags_2d_physics var enemy_layers: int:
	set(new):
		enemy_layers = new
		update()
@export_flags_2d_physics var enemy_mask: int:
	set(new):
		enemy_mask = new
		update()

func update() -> void:
	print("Player layers : ", player_layers)
	print("Player mask : ", player_mask)
	print("Enemy layers : ", enemy_layers)
	print("Enemy mask : ", enemy_mask)
