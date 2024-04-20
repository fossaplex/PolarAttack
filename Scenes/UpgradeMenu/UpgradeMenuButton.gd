extends Control

@onready var sprite_2d = $Button/Sprite2D
@onready var title = $Button/Title
@onready var description = $Button/Description

signal menuButtonPressed()

func _on_button_pressed():
	menuButtonPressed.emit()
