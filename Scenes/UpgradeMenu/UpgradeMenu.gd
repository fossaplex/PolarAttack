class_name UpgradeMenu
extends Control

const Modifiers = preload("res://Constants/Modifiers.gd")
var possible_upgrads := Modifiers.DATA

@onready var upgrade_button: UpgradeButton = $Control/VBoxContainer/UpgradeButton
@onready var upgrade_button_2: UpgradeButton = $Control/VBoxContainer/UpgradeButton2
@onready var upgrade_button_3: UpgradeButton = $Control/VBoxContainer/UpgradeButton3
@onready var upgrade_labal: Label = $Control/VBoxContainer/UpgradeLabal

@onready var option_buttons: Array[UpgradeButton] = [
	upgrade_button,
	upgrade_button_2,
	upgrade_button_3
]

signal toggle_game_paused(is_paused : bool)
signal on_upgrade_pressed(modifier: Modifier)

var upgrade_options: Array[Modifier] = []

func _ready() -> void:
	hide()
	upgrade_button.menu_button_pressed.connect(_on_upgrade_menu_button_menu_button_pressed)
	upgrade_button_2.menu_button_pressed.connect(_on_upgrade_menu_button_2_menu_button_pressed)
	upgrade_button_3.menu_button_pressed.connect(_on_upgrade_menu_button_3_menu_button_pressed)
	PlayerXpSignalBus.on_level_change.connect(open_upgrade_menu)

func open_upgrade_menu(level: int, _prev_level: int) -> void:
	if (level == 1): return
	upgrade_labal.text = str("Level Up (",level,")")
	get_tree().paused = true
	pick_upgrades()
	show()

func pick_upgrades() -> void:
	upgrade_options = get_random_upgrades()
	for i in range(option_buttons.size()):
		var modifier := upgrade_options[i]
		var option_button := option_buttons[i] as UpgradeButton
		option_button.modifier = modifier

func get_random_upgrades() -> Array[Modifier]:
	var picked_upgrade: Array[Modifier] = []
	for i in range(option_buttons.size()):
		var modifier_creator := Modifiers.DATA.pick_random() as Callable
		var modifier := modifier_creator.call() as Modifier
		picked_upgrade.append(modifier)

	return picked_upgrade

func _on_upgrade_menu_button_menu_button_pressed(modifier: Modifier) -> void:
	on_button_clicked(modifier)

func _on_upgrade_menu_button_2_menu_button_pressed(modifier: Modifier) -> void:
	on_button_clicked(modifier)

func _on_upgrade_menu_button_3_menu_button_pressed(modifier: Modifier) -> void:
	on_button_clicked(modifier)

func on_button_clicked(modifier: Modifier) -> void:
	on_upgrade_pressed.emit(modifier)
	get_tree().paused = false
	hide()
