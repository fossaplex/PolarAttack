extends Control

@export var level : Level
@onready var options_menu = $OptionsMenu as OptionsMenu
@onready var panel = $Panel as Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	level.connect("toggle_game_paused", _on_level_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_toggle_game_paused(is_paused : bool):
	if is_paused:
		show()
		panel.visible = true
		options_menu.visible = false
		
	else: 
		hide()


func _on_resume_button_pressed():
	level.game_paused = false


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	panel.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	

func _on_main_menu_button_pressed():
	level.game_paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")


func _on_options_menu_exit_options_menu():
	options_menu.visible = false
	panel.visible = true
