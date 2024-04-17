extends Label


@onready var seal = $".."

func _process(delta):
	text = ""
	text += str("H", seal.health, "/", seal.total_health)
