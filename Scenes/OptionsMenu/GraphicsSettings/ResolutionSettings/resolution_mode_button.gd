extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DICTIONARY : Dictionary = {
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080": Vector2i(1920, 1080)
}

func _ready() -> void:
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()
	load_data()
	
func load_data() -> void:
	on_resolution_selected(SettingsDataContainer.get_resolution_index())
	option_button.select(SettingsDataContainer.get_resolution_index())
func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)

func center_window():
	var center_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(center_screen - window_size/2)

func on_resolution_selected(index : int) -> void:
	SettingsSignalBus.emit_button_toggled(false)
	SettingsSignalBus.emit_set_resolution_selection_toggled(index)
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	center_window()


func _on_option_button_toggled(toggled_on):
	SettingsSignalBus.emit_button_toggled(toggled_on)
