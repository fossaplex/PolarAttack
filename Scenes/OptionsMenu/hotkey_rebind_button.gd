class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "move_left"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

## Main Handler for assigning the Action name, we can add more actions here later for what we want in the game
## I added what I thought we would need for now (Up down left right and two attacks)
func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"move_up":
			label.text = "Move Up"
		"move_down":
			label.text = "Move Down"
		"primary_attack":
			label.text = "Primary Attack"
		"secondary_attack":
			label.text = "Secondary Attack"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event = action_events[0]
		if action_event is InputEventKey:
			var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
			button.text = "%s" % action_keycode
		elif action_event is InputEventMouseButton:
			var action_mouse = OS.get_keycode_string(action_event.button_index)
			button.text = "%s" % "Mouse Button" + str(action_mouse)
		elif action_event is InputEventJoypadMotion:
			var action_axis = action_event.axis
			button.text = "%s" % "Joypad Axis: " + str(action_axis)
