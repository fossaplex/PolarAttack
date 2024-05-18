class_name OrbCountIncreaseModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

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
		weapons_handler.add_weapon(WeaponType.WEAPON_TYPE.ORB, 10, 1)
	queue_free()

func get_title() -> String:
	return "+ orb count"

func get_description() -> String:
	return "add +%d orbs" % increase_count_by

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "OrbCountIncreaseModifier"
