extends Control

@onready var current_level_label := $HBoxContainer/CurrentLevelLabel as Label

func _ready() -> void:
	PlayerXpSignalBus.on_level_change.connect(on_level_change)

func on_level_change(level: int, _prev_level: int) -> void:
	current_level_label.text = str(level)
