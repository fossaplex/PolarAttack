class_name AddWeaponModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")
const WeaponType = preload("res://Scripts/WeaponType.gd")

var weapon_type: WeaponType.WEAPON_TYPE

func _init(
	_weapon_type: WeaponType.WEAPON_TYPE,
	_level: int
) -> void:
	super._init(_level)
	weapon_type = _weapon_type

func _ready() -> void:
	weapons_handler.add_weapon(weapon_type, 35, 1)
	queue_free()

func get_title() -> String:
	match weapon_type:
		WeaponType.WEAPON_TYPE.ORB: return "** orb **"
		WeaponType.WEAPON_TYPE.BEAM: return "** beam **"
		WeaponType.WEAPON_TYPE.SWORD: return "** sword **"
	return ""

func get_description() -> String:
	match weapon_type:
		WeaponType.WEAPON_TYPE.ORB: return "gain spinning orb weapon"
		WeaponType.WEAPON_TYPE.BEAM: return "gain laser beam weapon"
		WeaponType.WEAPON_TYPE.SWORD: return "gain sword weapon"
	return ""

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 0

func get_tag() -> String:
	return "AddWeaponModifier"
