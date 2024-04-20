extends Control

@onready var state_label := $HBoxContainer/State_Label as Label
@onready var check_button := $HBoxContainer/CheckButton as CheckButton

func _ready() -> void:
	check_button.toggled.connect(on_subtitles_toggled)
	load_data()
	
func load_data() -> void:
	check_button.button_pressed = SettingsDataContainer.get_subtitles_toggled()
	on_subtitles_toggled(SettingsDataContainer.get_subtitles_toggled())
	
func set_label_text(button_pressed: bool) -> void:
	if button_pressed:
		state_label.text = "On"
	else:
		state_label.text = "Off"

func on_subtitles_toggled(button_pressed: bool) -> void:
	set_label_text(button_pressed)
	SettingsSignalBus.emit_set_subtitles_toggled(button_pressed)
	
