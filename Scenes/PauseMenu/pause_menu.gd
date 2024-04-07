extends Control

@export var level : Level


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
	else: 
		hide()


func _on_resume_button_pressed():
	level.game_paused = false


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	level.game_paused = false
	get_tree().change_scene_to_file("res://Scenes/OptionsMenu/options_menu.tscn")


func _on_main_menu_button_pressed():
	level.game_paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
