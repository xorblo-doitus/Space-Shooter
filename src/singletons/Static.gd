class_name ST

enum TEAM {Enemy = -1, Alone, Player}

const velocity_kept: float = 6

static func setup_collisions(obj: CollisionObject2D, team: TEAM, ghost: bool = false) -> CollisionObject2D:
	if team > 0:
		if ghost:
			obj.collision_layer = 0
		else:
			obj.collision_layer = 0b1
		obj.collision_mask = 0b11110000
	elif team < 0:
		if ghost:
			obj.collision_layer = 0
		else:
			obj.collision_layer = 0b10000
		obj.collision_mask = 0b1111
	else:
		push_warning("Alone team unimplemented")
	
	return obj
