class_name UpgradeMenuButton
extends Control

@onready var sprite_2d := $Button/Sprite2D
@onready var title := $Button/Title
@onready var description := $Button/Description
@onready var key : int

signal menuButtonPressed()

func _on_button_pressed() -> void:
	menuButtonPressed.emit()
