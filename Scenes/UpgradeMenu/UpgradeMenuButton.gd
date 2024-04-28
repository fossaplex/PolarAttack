class_name UpgradeMenuButton
extends Control

@onready var sprite_2d := $Button/Sprite2D
@onready var title := $Button/Title
@onready var description := $Button/Description
var key : int

var modifier : Modifier:
	set(value):
		modifier = value
		sprite_2d.texture = modifier.get_texture()
		title.text = modifier.get_title()
		description.text = modifier.get_description()

signal menuButtonPressed()

func _on_button_pressed() -> void:
	menuButtonPressed.emit()
