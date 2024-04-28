class_name PlayerHealthModifier
extends PlayerModifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var base_total_health_by: int

func _init(_base_total_health_by: int) -> void:
	base_total_health_by = _base_total_health_by

func _ready() -> void:
	player.base_total_health += base_total_health_by
	player.health += base_total_health_by

func get_title() -> String:
	return "+ + health"

func get_description() -> String:
	return "add +" + str(base_total_health_by) + " to base health"

func get_texture() -> Resource:
	return ICON

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "PlayerHealthModifier"
