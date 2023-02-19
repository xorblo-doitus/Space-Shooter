@tool
extends Node2D

## La distance en plus en dehors de l'écran
@export_range(-10, 20, 1, "or_less", "or_greater", "suffix:px") var margin: int = 0:
	set(new):
		margin = new
		change()
## L'épaisseur de la bordure
@export_range(1, 50, 1, "or_greater", "suffix:px") var width: int = 20:
	set(new):
		width = new
		change()

@export_range(0, 500, 1, "or_greater", "suffix:px") var enemy_margin: int = 100:
	set(new):
		enemy_margin = new
		change()

var is_ready: bool = false
func change(can_change: bool = Engine.is_editor_hint() and is_ready):
	if not can_change:
		return
	$LeftPlayer/VerticalShape.shape.size = Vector2i(width, ST.get_screen_height() + 2*(width+margin))
	$Up/HorizontalShape.shape.size = Vector2i(ST.get_screen_width() + 2*(width+margin+enemy_margin), width)
	$LeftPlayer.position = Vector2(-margin - width/2., ST.get_screen_height()/2.)
	$Up.position = Vector2(ST.get_screen_width()/2., -margin -width/2.)
	$Down.position = Vector2(ST.get_screen_width()/2., margin + ST.get_screen_height() + width/2.)
	
	$RightEnemy.position = Vector2(enemy_margin + margin + ST.get_screen_width() + width/2., ST.get_screen_height()/2.)
	$RightOneWay/VerticalShape.shape.size = Vector2i(ST.get_screen_height() + 2*(width+margin), width)
	$RightOneWay.position = Vector2(margin + ST.get_screen_width() + width/2., ST.get_screen_height()/2.)
	
	
func _ready():
	is_ready = true
	change(true)
