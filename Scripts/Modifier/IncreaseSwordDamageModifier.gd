class_name IncreaseSwordDamageModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_damage_by: int
func _init(
	_increase_damage_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_damage_by = _increase_damage_by

func _ready() -> void:
	var weapons := weapons_handler.weapons.get_children()
	for weapon: Weapon in weapons:
		if weapon is Swords:
			weapon.attackable.base_damage += increase_damage_by
	queue_free()

func get_title() -> String:
	return "+ sword damage"

func get_description() -> String:
	return "add +%d sword damage" % increase_damage_by

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "IncreaseSwordDamageModifier"
