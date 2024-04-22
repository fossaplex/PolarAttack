class_name PlayerHealthModifier
extends Modifier

static func createPlayerHealthModifier(_player:Player, _base_total_health_by: int) -> PlayerHealthModifier:
	var modifier := PlayerHealthModifier.new()
	modifier.player = _player
	modifier.base_total_health_by = _base_total_health_by
	return modifier
	

var player: Player
var base_total_health_by: int

func _ready() -> void:
	player.base_total_health += base_total_health_by

func get_type() -> ModifierType.Type:
	return ModifierType.Type.PLAYER
