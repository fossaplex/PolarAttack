class_name Attackable
extends Node

@export var damage: int

func deal_damange(charachter: Character) -> void:
	charachter.health = max(0 , charachter.health - damage)
