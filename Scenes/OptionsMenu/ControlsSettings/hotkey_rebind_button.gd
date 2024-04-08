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
		"move_up":
			label.text = "Move Up"
		"move_left":
			label.text = "Move Left"
		"move_down":
			label.text = "Move Down"
		"move_right":
			label.text = "Move Right"
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


func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press Any Key..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false;
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true;
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event):
	var is_duplicate=false
	var action_event=event
	var action_keycode=OS.get_keycode_string(action_event.physical_keycode)
	for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name!=self.action_name:
				if i.button.text=="%s" %action_keycode:
					is_duplicate=true
					break
	if not is_duplicate:
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name,event)
		set_process_unhandled_key_input(false)
		set_text_for_key()
		set_action_name()
	