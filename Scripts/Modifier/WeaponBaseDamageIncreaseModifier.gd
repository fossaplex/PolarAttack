class_name WeaponBaseDamageIncreaseModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_base_damage_by: int

func _init(
	_increase_base_damage_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_base_damage_by = _increase_base_damage_by

func _ready() -> void:
	for weapon: Weapon in weapons_handler.weapons.get_children():
		weapon.attackable.base_damage += increase_base_damage_by

func get_title() -> String:
	return "+ base damage"

func get_description() -> String:
	return "add +" + str(increase_base_damage_by) + "to base damage of all current weapons"

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "WeaponBaseDamageIncreaseModifier"
