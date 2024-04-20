extends Node

const SETTINGS_SAVE_PATH : String = "user://SettingsData.save"

var settings_data_dict : Dictionary = {}

func _ready() -> void:
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()

func on_settings_save(data: Dictionary) -> void:
	var save_settings_data_file := FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.WRITE)
	var json_data_string := JSON.stringify(data)
	save_settings_data_file.store_line(json_data_string)
	
func load_settings_data() -> void:
	if not FileAccess.file_exists(SETTINGS_SAVE_PATH):
		return
	
	var save_settings_data_file := FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.READ)
	var loaded_data : Dictionary = {}
	
	while save_settings_data_file.get_position() < save_settings_data_file.get_length():
		var json_string := save_settings_data_file.get_line()
		var json := JSON.new()
		var _parsed_result := json.parse(json_string)
		
		loaded_data = json.get_data()
	if loaded_data.has_all(["window_mode_index","resolution_index","master_volume","music_volume","sfx_volume","ambient_volume","subtitles_set","keybinds"]):
		SettingsSignalBus.emit_load_settings_data(loaded_data)
	else:
		loaded_data = {} 
		return
	
