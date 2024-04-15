class_name Attackable
extends Node

@export var damage: float

func deal_damange(charachter: Character) -> void:
	charachter.health = max(0 , charachter.health - damage)

func deal_damange_delta(charachter: Character, delta: float) -> void:
	var damage_this_frame = damage * delta
	charachter.health = max(0 , charachter.health - damage_this_frame)
	
func deal_damange_override(charachter: Character, new_damage: float) -> void:
	charachter.health = max(0 , charachter.health - new_damage)
