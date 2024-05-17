class_name UpgradeButton
extends Button

@onready var texture_rect: TextureRect = $MarginContainer/Control/HBoxContainer/TextureRect
@onready var title: Label = $MarginContainer/Control/HBoxContainer/CenterContainer/Title
@onready var description: Label = $MarginContainer/Control/Description

var modifiers : Array[Modifier]:
	set(value):
		if value.size() < 1: return
		modifiers = value
		var modifier := modifiers.front() as Modifier
		texture_rect.texture = modifier.get_texture()
		title.text = modifiers.reduce(func(accum: String, m: Modifier) -> String: return accum + "\n" + m.get_title(), "")
		description.text = modifiers.reduce(func(accum: String, m: Modifier) -> String: return accum + "\n" + m.get_description(), "")

signal menu_button_pressed(modifier:  Array[Modifier])

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	menu_button_pressed.emit(modifiers)
