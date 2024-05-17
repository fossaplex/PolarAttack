class_name AddSwordWeaponModifier
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
	var swords: Swords
	for weapon: Weapon in weapons:
		if weapon is Swords:
			swords = weapon
	if swords:
		swords.count += increase_count_by
	else:
		weapons_handler.add_weapon(WeaponType.WEAPON_TYPE.SWORD, 30, 1)
	queue_free()

func get_title() -> String:
	return "+ sword count"

func get_description() -> String:
	return "add +%d sword" % increase_count_by

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "AddSwordWeaponModifier"
