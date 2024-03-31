class_name MainMenu
extends Control

@onready var start_game_button = $MarginContainer/HBoxContainer/VBoxContainer/StartGameButton as Button
@onready var exit_game_button = $MarginContainer/HBoxContainer/VBoxContainer/ExitGameButton as Button
@onready var start_level = preload("res://Scenes/Levels/Level.tscn") as PackedScene

func _ready():
	start_game_button.button_down.connect(on_start_pressed)
	exit_game_button.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
