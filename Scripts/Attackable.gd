class_name Attackable
extends Node

signal on_damage_dealt(charachter: CharacterBase, damage: float)

@export var damage := 10.0

func deal_damange(charachter: CharacterBase) -> void:
	var previous_health = charachter.health
	charachter.health = max(0 , charachter.health - damage)
	if previous_health != charachter.health:
		on_damage_dealt.emit(charachter, damage)

func deal_damange_delta(charachter: CharacterBase, delta: float) -> void:
	var damage_this_frame = damage * delta
	var previous_health = charachter.health
	charachter.health = max(0 , charachter.health - damage_this_frame)
	if previous_health != charachter.health:
		on_damage_dealt.emit(charachter, damage)

func deal_damange_override(charachter: CharacterBase, new_damage: float) -> void:
	var previous_health = charachter.health
	charachter.health = max(0 , charachter.health - new_damage)
	if previous_health != charachter.health:
		on_damage_dealt.emit(charachter, damage)
