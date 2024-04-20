extends Control



@onready var optionButtons = [$VBoxContainer/UpgradeMenuButton, $VBoxContainer/UpgradeMenuButton2, $VBoxContainer/UpgradeMenuButton3]



@export var upgradeList: Array[BaseUpgradeResource] = []

signal toggle_game_paused(is_paused : bool)
var upgradeCount = 3
var upgradeOptions = []


func _ready() -> void:
	hide()
	SignalBus.on_open_upgrade_menu.connect(open_upgrade_menu)

func open_upgrade_menu():
	get_tree().paused = true
	pick_upgrades()
	show()
	
func pick_upgrades():
	upgradeOptions = get_random_upgrades(upgradeCount)
	for i in range(optionButtons.size()):
		optionButtons[i].sprite_2d.texture = upgradeOptions[i].texture
		optionButtons[i].title.text = upgradeOptions[i].title
		optionButtons[i].description.text = upgradeOptions[i].description

	

func get_random_upgrades(_upgradeCount: int):
	var currentUpgradeList = []
	currentUpgradeList.append_array(upgradeList)
	var pickedUpgrades = []
	for i in range(upgradeCount):
		pickedUpgrades.append(currentUpgradeList.pop_at(randi()%currentUpgradeList.size()))
	

	return pickedUpgrades

func _on_option_1_button_up():
	print("button 1 : " + str(upgradeOptions[1].upgrade_title))
	get_tree().paused = false
	hide()

func _on_option_2_button_up():
	print("button 2 : " + str(upgradeOptions[2].upgrade_title))
	get_tree().paused = false
	hide()

func _on_option_3_button_up():
	print("button 1 : " + str(upgradeOptions[1].upgrade_title))
	get_tree().paused = false
	hide()
	



func _on_v_box_container_gui_input(_event):
	print("This is a test")


func _on_upgrade_menu_button_menu_button_pressed():
	print("button 1 : " + str(upgradeOptions[0].title))
	get_tree().paused = false
	hide()


func _on_upgrade_menu_button_2_menu_button_pressed():
	print("button 2 : " + str(upgradeOptions[1].title))
	get_tree().paused = false
	hide()


func _on_upgrade_menu_button_3_menu_button_pressed():
	print("button 3 : " + str(upgradeOptions[2].title))
	get_tree().paused = false
	hide()
