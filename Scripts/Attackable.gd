class_name Attackable
extends Node

signal on_damage_dealt(character: CharacterBase, damage: float)

@export var damage := 10.0

func deal_damange(character: CharacterBase) -> void:
	var previous_health = character.health
	character.health = max(0 , character.health - damage)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)

func deal_damange_delta(character: CharacterBase, delta: float) -> void:
	var damage_this_frame = damage * delta
	var previous_health = character.health
	character.health = max(0 , character.health - damage_this_frame)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)

func deal_damange_override(character: CharacterBase, new_damage: float) -> void:
	var previous_health = character.health
	character.health = max(0 , character.health - new_damage)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)
