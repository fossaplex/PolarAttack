class_name AddWeaponModifier
extends Modifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var weapons_handler: WeaponHandler
var weapon_type: WeaponType.WEAPON_TYPE

func _init(
	_weapon_type: WeaponType.WEAPON_TYPE
) -> void:
	weapon_type = _weapon_type

func _ready() -> void:
	weapons_handler.add_weapon(weapon_type, 35, 1)

func add_dependecies(_weapons_handler: WeaponHandler) -> void:
	weapons_handler = _weapons_handler

func get_title() -> String:
	match weapon_type:
		WeaponType.WEAPON_TYPE.ORB: return "** orb **"
		WeaponType.WEAPON_TYPE.BEAM: return "** beam **"
	return ""

func get_description() -> String:
	match weapon_type:
		WeaponType.WEAPON_TYPE.ORB: return "gain spinning orb weapon"
		WeaponType.WEAPON_TYPE.BEAM: return "gain spinning laser beam"
	return ""

func get_texture() -> Resource:
	return ICON

func get_type() -> ModifierType.Type:
	return ModifierType.Type.WEAPON

func get_key() -> int:
	return 0

func get_tag() -> String:
	return "AddWeaponModifier"
