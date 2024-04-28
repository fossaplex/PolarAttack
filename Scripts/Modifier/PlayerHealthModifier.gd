class_name PlayerHealthModifier
extends Modifier

const ICON = preload("res://Graphics/Icons/icon.svg")

var player: Player
var base_total_health_by: int

func _init(_base_total_health_by: int) -> void:
	base_total_health_by = _base_total_health_by

func _ready() -> void:
	player.base_total_health += base_total_health_by
	player.health += base_total_health_by

func add_dependecies(_player: Player) -> void:
	player = _player

func get_title() -> String:
	return "+ + health"

func get_description() -> String:
	return "add +" + str(base_total_health_by) + " to base health"

func get_texture() -> Resource:
	return ICON

func get_type() -> ModifierType.Type:
	return ModifierType.Type.PLAYER

func get_key() -> int:
	return 2

func get_tag() -> String:
	return "PlayerHealthModifier"
