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

func change(can_change: bool = Engine.is_editor_hint()):
	if not can_change:
		return
	$Left/VerticalShape.shape.size = Vector2i(width, ST.get_screen_height() + 2*(width+margin))
	$Up/HorizontalShape.shape.size = Vector2i(ST.get_screen_width() + 2*(width+margin), width)
	$Left.position = Vector2(-margin - width/2., ST.get_screen_height()/2.)
	$Right.position = Vector2(margin + ST.get_screen_width() + width/2., ST.get_screen_height()/2.)
	$Up.position = Vector2(ST.get_screen_width()/2, -margin -width/2.)
	$Down.position = Vector2(ST.get_screen_width()/2, margin + ST.get_screen_height() + width/2.)

func _ready():
	change(true)
