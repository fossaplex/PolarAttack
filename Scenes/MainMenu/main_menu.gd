class_name MainMenu
extends Control

@onready var start_game_button := $MarginContainer/HBoxContainer/VBoxContainer/StartGameButton as Button
@onready var exit_game_button := $MarginContainer/HBoxContainer/VBoxContainer/ExitGameButton as Button
@onready var options_game_button := $MarginContainer/HBoxContainer/VBoxContainer/OptionsGameButton as Button
@onready var options_menu := $OptionsMenu as OptionsMenu
@onready var margin_container := $MarginContainer as MarginContainer

@onready var start_level := preload("res://Scenes/Levels/Level.tscn") as PackedScene

func _ready() -> void:
	handle_connecting_signals()

func on_start_pressed() -> void:
	SceneTransition.change_scene(start_level, "packed")

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false

func handle_connecting_signals() -> void:
	start_game_button.button_down.connect(on_start_pressed)
	options_game_button.button_down.connect(on_options_pressed)
	exit_game_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
