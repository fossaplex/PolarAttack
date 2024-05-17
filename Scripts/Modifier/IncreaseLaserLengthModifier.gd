class_name IncreaseLaserLengthModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_length_by: int

func _init(
	_increase_length_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_length_by = _increase_length_by

func _ready() -> void:
	var weapons := weapons_handler.weapons.get_children()
	for weapon: Weapon in weapons:
		if weapon is Beam:
			weapon.max_length += increase_length_by

func get_title() -> String:
	return "+ laser length"

func get_description() -> String:
	return "add +" + str(increase_length_by) + "ti laser length"

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "IncreaseLaserLengthModifier"
