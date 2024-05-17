class_name PlayerMoveSpeedModifier
extends PlayerModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var increase_speed_by: int

func _init(
	_increase_speed_by: int,
	_level: int
) -> void:
	super._init(_level)
	increase_speed_by = _increase_speed_by

func _ready() -> void:
	player.speed += increase_speed_by
	queue_free()

func get_title() -> String:
	return "+ speed"

func get_description() -> String:
	return "add +%d movement speed" % increase_speed_by 

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "PlayerMoveSpeedModifier"
