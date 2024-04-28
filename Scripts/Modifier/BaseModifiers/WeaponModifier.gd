class_name WeaponModifier
extends Modifier

var weapons_handler: WeaponHandler

func add_dependecies(_weapons_handler: WeaponHandler) -> void:
	weapons_handler = _weapons_handler
