extends Control

@onready var current_level_label = $HBoxContainer/CurrentLevelLabel as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	CollectableSignalBus.on_update_current_level_label.connect(update_level_ui)



func update_level_ui(value: int):
	current_level_label.text = str(value)
