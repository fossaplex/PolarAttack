class_name OrbCountIncreaseModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")
const WeaponType = preload("res://Scripts/WeaponType.gd")
const Weapon = preload("res://Scripts/Weapon.gd")

var increase_count_by: int

func _init(
	_increase_count_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_count_by = _increase_count_by

func _ready() -> void:
	var weapons := weapons_handler.weapons.get_children()
	var orbs: Orbs
	for weapon: Weapon in weapons:
		if weapon is Orbs:
			orbs = weapon
	if orbs:
		orbs.count += increase_count_by
	else:
		weapons_handler.add_weapon(WeaponType.WEAPON_TYPE.ORB, 30, 1)

func get_title() -> String:
	return "+ orb count"

func get_description() -> String:
	return "add +" + str(increase_count_by) + "orbs"

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "OrbCountIncreaseModifier"
