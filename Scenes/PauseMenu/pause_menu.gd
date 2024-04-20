extends Control

@export var level : Level
@onready var options_menu := $OptionsMenu as OptionsMenu
@onready var panel := $Panel as Panel

func _ready() -> void:
	hide()
	level.toggle_game_paused.connect(_on_level_toggle_game_paused)

func _on_level_toggle_game_paused(is_paused : bool) -> void:
	if is_paused:
		show()
		panel.visible = true
		options_menu.visible = false
		
	else: 
		hide()

func _on_resume_button_pressed() -> void:
	level.game_paused = false

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	panel.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func _on_main_menu_button_pressed() -> void:
	level.game_paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

func _on_options_menu_exit_options_menu() -> void:
	options_menu.visible = false
	panel.visible = true
