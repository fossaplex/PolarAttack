class_name WeaponBaseDamageIncreaseModifier
extends Modifier

static func createWeaponBaseDamageIncreaseModifier(
	_weapons: Array,
	_increase_base_damage_by: int
) -> WeaponBaseDamageIncreaseModifier:
	var modifier := WeaponBaseDamageIncreaseModifier.new()
	modifier.weapons = _weapons
	modifier.increase_base_damage_by = _increase_base_damage_by
	return modifier

var weapons: Array
var increase_base_damage_by: int

func _ready() -> void:
	for weapon: Weapon in weapons:
		weapon.attackable.base_damage += increase_base_damage_by

func get_type() -> ModifierType.Type:
	return ModifierType.Type.WEAPON
