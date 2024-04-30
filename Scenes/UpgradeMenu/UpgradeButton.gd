class_name UpgradeButton
extends Button

@onready var texture_rect: TextureRect = $MarginContainer/Control/HBoxContainer/TextureRect
@onready var title: Label = $MarginContainer/Control/HBoxContainer/CenterContainer/Title
@onready var description: Label = $MarginContainer/Control/Description

var modifier : Modifier:
	set(value):
		modifier = value
		texture_rect.texture = modifier.get_texture()
		title.text = modifier.get_title()
		description.text = modifier.get_description()

signal menu_button_pressed(modifier: Modifier)

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	menu_button_pressed.emit(modifier)
