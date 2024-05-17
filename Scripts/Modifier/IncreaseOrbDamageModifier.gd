class_name IncreaseOrbDamageModifier
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
		if weapon is Orbs:
			weapon.attackable.base_damage += increase_damage_by
	queue_free()

func get_title() -> String:
	return "+ orb damage"

func get_description() -> String:
	return "add +%d orb damage +" % increase_damage_by

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "IncreaseOrbDamageModifier"
