class_name HotkeyRebindButton
extends Control

@onready var label := $HBoxContainer/Label as Label
@onready var button := $HBoxContainer/Button as Button

@export var action_name : String = "move_left"

var mouse_button_pressed := false
var space_or_enter_pressed := false

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_process_input(false)
	set_action_name()
	set_text_for_input()
	load_keybinds()

func load_keybinds() -> void:
	rebind_action_key(SettingsDataContainer.get_keybinds(action_name))

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

func set_text_for_input() -> void:
	var action_events := InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event := action_events[0]
		if action_event is InputEventKey:
			var action_keycode := OS.get_keycode_string(action_event.physical_keycode)
			button.text = "%s" % action_keycode
		elif action_event is InputEventMouseButton:
			var action_mouse := action_event.button_index as MouseButton
			match action_mouse:
				1:
					button.text = "Left Click Button"
				2:
					button.text = "Right Click Button"
				3:
					button.text = "Middle Mouse Button"
				4:
					button.text = "Mouse Wheel Up"
				5:
					button.text = "Mouse Wheel Down"
				6:
					button.text = "Mouse Wheel Left"
				7:
					button.text = "Middle Mouse Button"
				4:
					button.text = "Mouse Wheel Right"
				_:
					button.text = "Mouse Button: %s" % action_mouse
				
			
		elif action_event is InputEventJoypadMotion:
			var action_axis := action_event.axis as JoyAxis
			button.text = "%s" % "Joypad Axis: " + str(action_axis)
	set_process_input(false)

func _on_button_toggled(button_pressed: bool) -> void:
	SettingsSignalBus.emit_button_toggled(button_pressed)
	if button_pressed:
		button.text = "Press Any Key/Input..."
		set_process_unhandled_input(button_pressed)
		set_process_input(button_pressed)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true;
				i.set_process_unhandled_key_input(false)
				i.set_process_input(false)
		set_text_for_input()

#NOTE - This logic works for Space, Enter, and Left Click
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if OS.get_keycode_string(event.key_label) != "Escape":
			if OS.get_keycode_string(event.key_label) == "Enter" or OS.get_keycode_string(event.key_label) == "Space":
				if space_or_enter_pressed:
					rebind_action_key(event)
					button.button_pressed = false
					space_or_enter_pressed = true
				elif not event.pressed:
					rebind_action_key(event)
					space_or_enter_pressed = false
			elif not event.pressed:
				rebind_action_key(event)
				button.button_pressed = false
				space_or_enter_pressed = false
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_button_pressed:
				rebind_action_key(event)
				button.button_pressed = false
				mouse_button_pressed = true
			elif not event.pressed:
				rebind_action_key(event)
				mouse_button_pressed = false
		elif not event.pressed:
			rebind_action_key(event)
			button.button_pressed = false
			mouse_button_pressed = false

func rebind_action_key(event: InputEvent) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name,event)
	SettingsDataContainer.set_keybind(action_name, event)
	set_process_unhandled_key_input(false)
	set_process_input(false)
	set_text_for_input()
	set_action_name()
	SettingsSignalBus.emit_button_toggled(false)
	
