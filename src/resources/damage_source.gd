extends Resource

class_name DamageSource

# Non ne devrait pas contenir la team
#@export var team: ST.TEAM = ST.TEAM.Enemy
@export_range(0, 100, 0.1, "or_greater", "suffix:⚔") var damage: float = 10
@export_range(0, 5, 0.01, "or_greater", "suffix:*") var knockback_multiplier: float = 1
