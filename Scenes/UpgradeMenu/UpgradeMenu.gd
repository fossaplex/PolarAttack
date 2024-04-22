class_name UpgradeMenu
extends Control



@onready var optionButtons := [$VBoxContainer/UpgradeMenuButton, $VBoxContainer/UpgradeMenuButton2, $VBoxContainer/UpgradeMenuButton3]



@export var upgradeList: Array[BaseUpgradeResource] = []

signal toggle_game_paused(is_paused : bool)
signal on_upgrade_pressed(key: int)

var upgradeCount := 3
var upgradeOptions := []


func _ready() -> void:
	hide()
	SignalBus.on_open_upgrade_menu.connect(open_upgrade_menu)

func open_upgrade_menu() -> void:
	get_tree().paused = true
	pick_upgrades()
	show()
	
func pick_upgrades() -> void:
	upgradeOptions = get_random_upgrades(upgradeCount)
	for i in range(optionButtons.size()):
		optionButtons[i].sprite_2d.texture = upgradeOptions[i].texture
		optionButtons[i].title.text = upgradeOptions[i].title
		optionButtons[i].description.text = upgradeOptions[i].description

func get_random_upgrades(_upgradeCount: int) -> Array:
	var currentUpgradeList := []
	currentUpgradeList.append_array(upgradeList)
	var pickedUpgrades := []
	for i in range(upgradeCount):
		pickedUpgrades.append(currentUpgradeList.pop_at(randi()%currentUpgradeList.size()))

	return pickedUpgrades

func _on_option_1_button_up() -> void:
	print("button 1 : " + str(upgradeOptions[1].upgrade_title))
	on_upgrade_pressed.emit(upgradeOptions[1].value)
	get_tree().paused = false
	hide()

func _on_option_2_button_up() -> void:
	print("button 2 : " + str(upgradeOptions[2].upgrade_title))
	on_upgrade_pressed.emit(upgradeOptions[2].value)
	get_tree().paused = false
	hide()

func _on_option_3_button_up() -> void:
	print("button 1 : " + str(upgradeOptions[1].upgrade_title))
	on_upgrade_pressed.emit(upgradeOptions[2].value)
	get_tree().paused = false
	hide()

func _on_v_box_container_gui_input(_event: InputEvent) -> void:
	print("This is a test")

func _on_upgrade_menu_button_menu_button_pressed() -> void:
	print("button 1 : " + str(upgradeOptions[0].title))
	on_upgrade_pressed.emit(upgradeOptions[0].value)
	get_tree().paused = false
	hide()

func _on_upgrade_menu_button_2_menu_button_pressed() -> void:
	print("button 2 : " + str(upgradeOptions[1].title))
	on_upgrade_pressed.emit(upgradeOptions[1].value)
	get_tree().paused = false
	hide()

func _on_upgrade_menu_button_3_menu_button_pressed() -> void:
	print("button 3 : " + str(upgradeOptions[2].title))
	on_upgrade_pressed.emit(upgradeOptions[2].value)
	get_tree().paused = false
	hide()
