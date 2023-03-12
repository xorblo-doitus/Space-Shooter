@tool
extends Resource
class_name EntityInfo

const default_times = [
	0, # 0 Unobtainable
	2.5, # -1 Normal
	4, # -2 Moderate
]

@export var entity: PackedScene
@export var spawn_time: float = 2.5
@export var warning_popup_image: Texture2D
@export var warning_popu_arrow: Texture2D = preload("res://assets/sprites/popups/alert_arrow.png")


func _init()-> void:
	call_deferred("ready")

func ready() -> void:
	prints(entity, "selected")
	assert(entity, "No entity defined on entity info at " + resource_path)
	var test_entity = entity.instantiate()
	assert(test_entity is Entity, "The packed scene associated with %s is not an entity." % resource_path)
	test_entity.queue_free()

func get_spawn_time() -> float:
	if spawn_time < 0:
		return default_times[int(spawn_time)]
	
	return spawn_time

func new() -> Vessel:
	return entity.instantiate()
