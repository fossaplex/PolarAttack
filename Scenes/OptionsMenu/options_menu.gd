class_name OptionsMenu
extends Control

@onready var exit_settings_button = $MarginContainer/VBoxContainer/ExitSettingsButton as Button

signal exit_options_menu

func _ready():
	exit_settings_button.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_options_menu.emit()
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)
