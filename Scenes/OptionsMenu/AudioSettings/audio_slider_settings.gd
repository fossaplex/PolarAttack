extends Control

@onready var audio_name_label = $HBoxContainer/AudioNameLabel as Label
@onready var audio_num_label = $HBoxContainer/AudioNumLabel as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Music", "SFX", "Ambient") var bus_name : String

var bus_index : int = 0

func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()

func set_name_label_text() -> void:
	audio_name_label.text = str(bus_name) + " Volume"
	
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
func set_audio_number_label_text() -> void:
	var slider_value = h_slider.value
	audio_num_label.text = str(slider_value * 100) + "%"
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_number_label_text()

func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_number_label_text()
	print("Hit on_value_changed")
	print(bus_index)
	match bus_index:
		0:
			SettingsSignalBus.emit_on_master_sound_set(value)
		1:
			SettingsSignalBus.emit_on_music_sound_set(value)
		2:
			SettingsSignalBus.emit_on_sfx_sound_set(value)
		3:
			SettingsSignalBus.emit_on_ambient_sound_set(value)

