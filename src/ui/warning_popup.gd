@tool
extends CanvasGroup
class_name WarningPopup


const default_overlays: Array[Texture2D] = [
	
]
const default_arrows: Array[Texture2D] = [
	preload("res://assets/sprites/popups/alert_arrow.png")
]


func _ready():
	$ArrowPivot/Arrow/AnimationPlayer.play("float")
	set_process(Engine.is_editor_hint())
#	print(Engine.is_editor_hint())
#
#func _process(delta):
#	print("allo")
#	target_pos = get_global_mouse_position()
#	update_arrow()
#
#func _process(delta):
#	print(global_position, %ArrowPivot.global_position)
#	update_arrow()

var target_pos: Vector2 = Vector2.ZERO
func setup(new_target_pos, icon_overlay_texture = null, icon_texture: Texture2D = null, arrow_texture = null) -> WarningPopup:
	if icon_overlay_texture:
		if icon_overlay_texture is int:
			assert(0 <= icon_overlay_texture < len(default_overlays), "No icon overlay with id %d" % icon_overlay_texture)
			icon_overlay_texture = default_overlays[icon_overlay_texture]
		%IconOverlay.texture = icon_overlay_texture
	
	if target_pos == null:
		%Arrow.hide()
	else:
		if arrow_texture:
			if arrow_texture is int:
				assert(0 <= arrow_texture < len(default_arrows), "No arrow with id %d" % arrow_texture)
				arrow_texture = default_arrows[arrow_texture]
			%Arrow.texture = arrow_texture
	
	if icon_texture:
		%Icon.texture = icon_texture
	
	target_pos = new_target_pos
	
	update_arrow()
	
	return self


func update_arrow() -> WarningPopup:
	%ArrowPivot.look_at(target_pos)
	return self
