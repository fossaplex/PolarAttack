class_name OrbCountAndSpeedIncreaseModifier
extends Modifier

static func createOrbCountAndSpeedIncreaseModifier(
	_orbs: Orbs,
	_increase_count_by: int,
	_increase_speed_by: int
) -> OrbCountAndSpeedIncreaseModifier:
	var modifier := OrbCountAndSpeedIncreaseModifier.new()
	modifier.orbs = _orbs
	modifier.increase_count_by = _increase_count_by
	modifier.increase_speed_by = _increase_speed_by
	return modifier

var orbs: Orbs
var increase_count_by: int
var increase_speed_by: int

func _ready() -> void:
	orbs.count += increase_count_by
	orbs.speed += increase_speed_by

func get_type() -> ModifierType.Type:
	return ModifierType.Type.ORBS
