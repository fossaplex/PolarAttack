class_name SettingsTabContainer
extends Control

@onready var tab_container = $TabContainer as TabContainer

signal Exit_Options_Menu

func _process(delta):
	options_menu_input()
	
func change_tab(currentTab : int) -> void:
	tab_container.set_current_tab(currentTab)

func options_menu_input() -> void:
	if SettingsSignalBus.rebind_button_active == false:
		if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
			if tab_container.current_tab >= tab_container.get_tab_count() -1:
				change_tab(0)
				return
			change_tab(tab_container.current_tab + 1)
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
			if tab_container.current_tab == 0:
				change_tab(tab_container.get_tab_count() - 1)
				return
			change_tab(tab_container.current_tab - 1)
		if Input.is_action_just_pressed("ui_cancel"):
			Exit_Options_Menu.emit()
	else:
		pass
