extends Control

@onready var current_level_label = $HBoxContainer/CurrentLevelLabel as Label

func _ready() -> void:
	SignalBus.on_update_current_level_label.connect(update_level_ui)



func update_level_ui(value: int):
	current_level_label.text = str(value)
