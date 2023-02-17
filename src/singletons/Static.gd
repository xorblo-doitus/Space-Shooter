class_name ST

enum TEAM {Enemy = -1, Alone, Player}

## This prevent a weird bug where instantiated bullets are missing their DamageSource
const bullet_cache := [preload("res://src/bullets/basic_bullet.tscn")]

const velocity_kept: float = 6


## Choose the right layers and masks according to team
static func setup_collisions(obj: CollisionObject2D, team: TEAM, ghost: bool = false) -> CollisionObject2D:
	if team > 0:
		# Player
		if ghost:
			obj.collision_layer = 0
		else:
			obj.collision_layer = 15
		obj.collision_mask = 496
	elif team < 0:
		# Enemy
		if ghost:
			obj.collision_layer = 0
		else:
			obj.collision_layer = 240
		obj.collision_mask = 527
	else:
		# Alone
		push_warning("Alone team unimplemented")
	
	return obj

static func get_screen_height() -> int:
	return ProjectSettings.get_setting("display/window/size/viewport_height")
static func get_screen_width() -> int:
	return ProjectSettings.get_setting("display/window/size/viewport_width")
