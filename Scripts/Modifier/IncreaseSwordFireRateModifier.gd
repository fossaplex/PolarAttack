class_name IncreaseSwordFireRateModifier
extends WeaponModifier

static var CAP := 1.0

const ICON = preload("res://Graphics/Icons/icon.svg")

var _increase_fire_rate_by: float
func _init(
	__increase_fire_rate_by: float,
	_level: int
) -> void:
	super._init(_level)
	_increase_fire_rate_by = __increase_fire_rate_by

func _ready() -> void:
	var weapons := weapons_handler.weapons.get_children()
	for weapon: Weapon in weapons:
		if weapon is Swords:
			weapon.cooldown = maxf(weapon.cooldown - _increase_fire_rate_by, CAP)
	queue_free()

func get_title() -> String:
	return "+ sword fire rate"

func get_description() -> String:
	return "add +%.1f fire rate +" % _increase_fire_rate_by

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "IncreaseSwordFireRateModifier"
