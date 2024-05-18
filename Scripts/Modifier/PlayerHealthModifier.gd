class_name PlayerHealthModifier
extends PlayerModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var base_total_health_by: int

func _init(
	_base_total_health_by: int,
	_level: int
) -> void:
	super._init(_level)
	base_total_health_by = _base_total_health_by

func _ready() -> void:
	player.base_total_health += base_total_health_by * level
	player.health += base_total_health_by * level
	queue_free()

func get_title() -> String:
	return "+ health"

func get_description() -> String:
	return "add +%d to base health" % (base_total_health_by * level)

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "PlayerHealthModifier"
