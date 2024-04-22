class_name AttackableResource 
extends Resource

@export var base_damage := 10.0
@export var multiplier := 1.0

func _init(_base_damage: float = 10.0, _multiplier: float = 1.0) -> void:
	self.base_damage = _base_damage
	self.multiplier = _multiplier
