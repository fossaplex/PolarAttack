class_name WeaponBaseDamageIncreaseModifier
extends Modifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var weapons: Array
var increase_base_damage_by: int

func _init(
	_increase_base_damage_by: int
) -> void:
	increase_base_damage_by = _increase_base_damage_by

func _ready() -> void:
	for weapon: Weapon in weapons:
		weapon.attackable.base_damage += increase_base_damage_by

func add_dependecies(_weapons: Array,) -> void:
	weapons = _weapons

func get_title() -> String:
	return "+ base damage"

func get_description() -> String:
	return "add +" + str(increase_base_damage_by) + "to base damage of all current weapons"

func get_texture() -> Resource:
	return ICON

func get_type() -> ModifierType.Type:
	return ModifierType.Type.WEAPON

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "WeaponBaseDamageIncreaseModifier"
