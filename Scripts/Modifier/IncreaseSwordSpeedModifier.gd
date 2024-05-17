class_name IncreaseSwordSpeedModifier
extends WeaponModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_speed_by: int
func _init(
	_increase_speed_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_speed_by = _increase_speed_by

func _ready() -> void:
	var weapons := weapons_handler.weapons.get_children()
	for weapon: Weapon in weapons:
		if weapon is Swords:
			weapon.speed += increase_speed_by
	queue_free()

func get_title() -> String:
	return "+ sword speed"

func get_description() -> String:
	return "add +" + str(increase_speed_by) + "speed +"

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "IncreaseSwordSpeedModifier"
