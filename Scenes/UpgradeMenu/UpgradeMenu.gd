class_name UpgradeMenu
extends Control

const Modifiers = preload("res://Constants/Modifiers.gd")
var possible_upgrads := Modifiers.DATA

@onready var option_buttons := [$VBoxContainer/UpgradeMenuButton, $VBoxContainer/UpgradeMenuButton2, $VBoxContainer/UpgradeMenuButton3]

signal toggle_game_paused(is_paused : bool)
signal on_upgrade_pressed(modifier: Modifier)

var upgrade_options: Array[Modifier] = []

func _ready() -> void:
	hide()
	PlayerXpSignalBus.on_level_change.connect(open_upgrade_menu)

func open_upgrade_menu(level: int, _prev_level: int) -> void:
	if (level == 1): return
	get_tree().paused = true
	pick_upgrades()
	show()

func pick_upgrades() -> void:
	upgrade_options = get_random_upgrades()
	for i in range(option_buttons.size()):
		var modifier := upgrade_options[i]
		var option_button := option_buttons[i] as UpgradeMenuButton
		option_button.modifier = modifier

func get_random_upgrades() -> Array[Modifier]:
	var picked_upgrade: Array[Modifier] = []
	for i in range(option_buttons.size()):
		var modifier_creator := Modifiers.DATA.pick_random() as Callable
		var modifier := modifier_creator.call() as Modifier
		picked_upgrade.append(modifier)

	return picked_upgrade

func _on_upgrade_menu_button_menu_button_pressed() -> void:
	on_button_clicked(0)

func _on_upgrade_menu_button_2_menu_button_pressed() -> void:
	on_button_clicked(1)

func _on_upgrade_menu_button_3_menu_button_pressed() -> void:
	on_button_clicked(2)

func on_button_clicked(index: int) -> void:
	var button := option_buttons[index] as UpgradeMenuButton
	var modifier := button.modifier
	on_upgrade_pressed.emit(modifier)
	get_tree().paused = false
	hide()
