extends Node

signal set_subtitles_toggled(value: bool)

signal set_window_mode_selected(index: int)
signal set_resolution_selected(index: int)

signal set_master_sound_set(value: float)
signal set_music_sound_set(value: float)
signal set_sfx_sound_set(value: float)
signal set_ambient_sound_set(value: float)

signal set_settings_dictionary(settings_dict : Dictionary)

signal load_settings_data(settings_dict : Dictionary)

func emit_load_settings_data(settings_dict: Dictionary) -> void:
	load_settings_data.emit(settings_dict)
func emit_set_settings_dictionary(settings_dict: Dictionary) -> void:
	set_settings_dictionary.emit(settings_dict)
	
func emit_set_subtitles_toggled(value: bool) -> void:
	set_subtitles_toggled.emit(value)

func emit_set_window_mode_toggled(index: int) -> void:
	set_window_mode_selected.emit(index)
func emit_set_resolution_selection_toggled(index: int) -> void:
	set_resolution_selected.emit(index)

func emit_set_master_sound_set(value: float) -> void:
	set_master_sound_set.emit(value)
func emit_set_music_sound_set(value: float) -> void:
	set_music_sound_set.emit(value)
func emit_set_sfx_sound_set(value: float) -> void:
	set_sfx_sound_set.emit(value)
func emit_set_ambient_sound_set(value: float) -> void:
	set_ambient_sound_set.emit(value)
