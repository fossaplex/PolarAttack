class_name AddWeaponModifier
extends Modifier

static func createAddWeaponModifier(
	_weapons_handler: WeaponHandler,
	_weapon_type: WeaponType.WEAPON_TYPE
) -> AddWeaponModifier:
	var modifier := AddWeaponModifier.new()
	modifier.weapons_handler = _weapons_handler
	modifier.weapon_type = _weapon_type
	return modifier

var weapons_handler: WeaponHandler
var weapon_type: WeaponType.WEAPON_TYPE

func _ready() -> void:
	weapons_handler.add_weapon(weapon_type, 35, 1)

func get_type() -> ModifierType.Type:
	return ModifierType.Type.WEAPON
