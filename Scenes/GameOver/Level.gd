extends Label

func _process(_delta: float) -> void:
	text = str(GameStats.player_level)
