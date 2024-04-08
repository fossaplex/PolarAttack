extends Node

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://Scenes/Resources/DefaultSettings.tres")
#Graphics 
var window_mode_index : int = 0
var resolution_index: int = 0

#Volume
var master_volume: float = 0.0
var music_volume: float = 0.0
var sfx_volume: float = 0.0
var ambient_volume: float = 0.0

#Accessibility
var subtitles_set: bool = false

#Menu Save Data
var loaded_data : Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()

func create_storage_dictionary() -> Dictionary:
	var settings_container_dict: Dictionary = {
		"window_mode_index": window_mode_index,
		"resolution_index": resolution_index,
		"master_volume": master_volume,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"ambient_volume": ambient_volume,
		"subtitles_set": subtitles_set,
	}
	return settings_container_dict

#Getters
func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return window_mode_index
func get_resolution_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index
func get_subtitles_toggled() -> bool:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SUBTITLES_SET
	return subtitles_set
func get_master_sound() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume
func get_music_sound() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume
func get_sfx_sound() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume
func get_ambient_sound() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_AMBIENT_VOLUME
	return ambient_volume

func set_window_mode_selected(index: int) -> void:
	window_mode_index = index
func set_resolution_selected(index: int) -> void:
	resolution_index = index
func set_subtitles_toggled(toggled: bool) -> void:
	subtitles_set = toggled
func set_master_sound_set(value: float) -> void:
	master_volume = value
func set_music_sound_set(value: float) -> void:
	music_volume = value
func set_sfx_sound_set(value: float) -> void:
	sfx_volume = value
func set_ambient_sound_set(value: float) -> void:
	ambient_volume = value
	
func on_settings_data_loaded(data: Dictionary) -> void:
	loaded_data = data
	set_window_mode_selected(loaded_data.window_mode_index)
	set_resolution_selected(loaded_data.resolution_index)
	set_subtitles_toggled(loaded_data.subtitles_set)
	set_master_sound_set(loaded_data.master_volume)
	set_music_sound_set(loaded_data.music_volume)
	set_sfx_sound_set(loaded_data.sfx_volume)
	set_ambient_sound_set(loaded_data.ambient_volume)

func handle_signals() -> void:
	SettingsSignalBus.set_window_mode_selected.connect(set_window_mode_selected)
	SettingsSignalBus.set_resolution_selected.connect(set_resolution_selected)
	SettingsSignalBus.set_subtitles_toggled.connect(set_subtitles_toggled)
	SettingsSignalBus.set_master_sound_set.connect(set_master_sound_set)
	SettingsSignalBus.set_music_sound_set.connect(set_music_sound_set)
	SettingsSignalBus.set_sfx_sound_set.connect(set_sfx_sound_set)
	SettingsSignalBus.set_ambient_sound_set.connect(set_ambient_sound_set)
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
