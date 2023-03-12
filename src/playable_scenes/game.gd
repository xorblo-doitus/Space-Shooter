extends CanvasLayer

@onready var popup_manager: PopupManager = %PopupManager
@onready var world: World = %World

func _ready():
	for spawner in world.get_spawners():
		spawner.warn.connect(popup_manager.add_popup)
		
		
