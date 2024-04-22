class_name UpgradeMenu
extends Control

const ModifierData = preload("res://Constants/ModifierData.gd")
var possible_upgrads := ModifierData.DATA

@onready var option_buttons := [$VBoxContainer/UpgradeMenuButton, $VBoxContainer/UpgradeMenuButton2, $VBoxContainer/UpgradeMenuButton3]
@export var upgrade_list: Array[BaseUpgradeResource] = []

signal toggle_game_paused(is_paused : bool)
signal on_upgrade_pressed(key: int)

var upgrade_count := 3
var upgrade_options_keys := []

func _ready() -> void:
	hide()
	SignalBus.on_open_upgrade_menu.connect(open_upgrade_menu)

func open_upgrade_menu() -> void:
	get_tree().paused = true
	pick_upgrades()
	show()

func pick_upgrades() -> void:
	upgrade_options_keys = get_random_upgrades_keys(upgrade_count)
	for i in range(option_buttons.size()):
		var modifer_data := possible_upgrads[upgrade_options_keys[i]] as ModifierData.ModifierData
		var option_button := option_buttons[i] as UpgradeMenuButton
		option_button.sprite_2d.texture = modifer_data.texture
		option_button.title.text = modifer_data.title
		option_button.description.text = modifer_data.description
		option_button.key = modifer_data.key

func get_random_upgrades_keys(_upgrade_count: int) -> Array[int]:
	var picked_upgrade_keys: Array[int] = []
	for i in range(_upgrade_count):
		picked_upgrade_keys.append(ModifierData.DATA.keys().pick_random())

	return picked_upgrade_keys

func _on_v_box_container_gui_input(_event: InputEvent) -> void:
	print("This is a test")

func _on_upgrade_menu_button_menu_button_pressed() -> void:
	var button = option_buttons[0] as UpgradeMenuButton
	var modifer_data := possible_upgrads[button.key] as ModifierData.ModifierData
	print("button 1 : " + str(modifer_data.title))
	on_upgrade_pressed.emit(modifer_data.key)
	get_tree().paused = false
	hide()

func _on_upgrade_menu_button_2_menu_button_pressed() -> void:
	var button = option_buttons[1] as UpgradeMenuButton
	var modifer_data := possible_upgrads[button.key] as ModifierData.ModifierData
	print("button 2 : " + str(modifer_data.title))
	on_upgrade_pressed.emit(modifer_data.key)
	get_tree().paused = false
	hide()

func _on_upgrade_menu_button_3_menu_button_pressed() -> void:
	var button = option_buttons[2] as UpgradeMenuButton
	var modifer_data := possible_upgrads[button.key] as ModifierData.ModifierData
	print("button 3 : " + str(modifer_data.title))
	on_upgrade_pressed.emit(modifer_data.key)
	get_tree().paused = false
	hide()
