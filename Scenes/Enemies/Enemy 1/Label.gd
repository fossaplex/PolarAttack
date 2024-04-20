extends Label


@onready var seal := $".."

func _process(_delta: float) -> void:
	text = ""
	text += str("H", seal.health, "/", seal.total_health)
