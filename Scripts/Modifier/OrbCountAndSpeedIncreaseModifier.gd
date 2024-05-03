class_name OrbCountAndSpeedIncreaseModifier
extends OrbsModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_count_by: int
var increase_speed_by: int

func _init(
	_increase_count_by: int,
	_increase_speed_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_count_by = _increase_count_by
	increase_speed_by = _increase_speed_by

func _ready() -> void:
	orbs.count += increase_count_by
	orbs.speed += increase_speed_by

func get_title() -> String:
	return "+ orb count and speed"

func get_description() -> String:
	return "add +" + str(increase_count_by) + "orbs and increses orb speed +" + str(increase_speed_by)

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 1

func get_tag() -> String:
	return "OrbCountAndSpeedIncreaseModifier"
