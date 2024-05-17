class_name GameOverScene
extends CanvasLayer


@onready var new_game_button := $PanelContainer/MarginContainer/MainVboxContainer/HBoxContainer/NewGameButton as Button
@onready var main_menu_button := $PanelContainer/MarginContainer/MainVboxContainer/HBoxContainer/MainMenuButton as Button
@onready var exit_game_button := $PanelContainer/MarginContainer/MainVboxContainer/HBoxContainer/ExitGameButton as Button

@onready var start_level := preload("res://Scenes/Levels/Level.tscn") as PackedScene

func _ready() -> void:
	handle_connecting_signals()

func on_start_pressed() -> void:
	SceneTransition.change_scene(start_level, "packed")

func on_exit_pressed() -> void:
	get_tree().quit()

func on_main_menu_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/MainMenu/main_menu.tscn", "file")

func handle_connecting_signals() -> void:
	new_game_button.button_down.connect(on_start_pressed)
	main_menu_button.button_down.connect(on_main_menu_pressed)
	exit_game_button.button_down.connect(on_exit_pressed)
