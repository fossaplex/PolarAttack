extends Node

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
		"move_left": InputMap.action_get_events("move_left"),
		"move_right": InputMap.action_get_events("move_right"),
		"move_up": InputMap.action_get_events("move_up"),
		"move_down": InputMap.action_get_events("move_down"),
	}
	print(settings_container_dict)
	return settings_container_dict

func on_window_mode_selected(index: int) -> void:
	window_mode_index = index
func on_resolution_selected(index: int) -> void:
	resolution_index = index
func on_subtitles_toggled(toggled: bool) -> void:
	subtitles_set = toggled
func on_master_sound_set(value: float) -> void:
	master_volume = value
func on_music_sound_set(value: float) -> void:
	music_volume = value
func on_sfx_sound_set(value: float) -> void:
	sfx_volume = value
func on_ambient_sound_set(value: float) -> void:
	ambient_volume = value

func handle_signals() -> void:
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_subtitles_toggled.connect(on_subtitles_toggled)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	SettingsSignalBus.on_ambient_sound_set.connect(on_ambient_sound_set)
