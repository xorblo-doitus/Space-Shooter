extends HBoxContainer

@onready var combo_displayer: NumberDisplayer = $Combo
@onready var score_displayer: NumberDisplayer  = $Score

#var score: float = 0:
#	set(new): score_displayer.number = score
#var combo: float = 0:
#	set(new): score_displayer.number = score

#func _ready():
#	Callable(combo_displayer, "@number_setter").call(10)
	

func bind_player(player: PlayerVessel) -> void:
	player.score_changed.connect(Callable(score_displayer, "@number_setter"))
	score_displayer.number = player.score
	score_displayer.update_text()
	player.combo_changed.connect(Callable(combo_displayer, "@number_setter"))
	combo_displayer.number = player.combo
	combo_displayer.update_text()
