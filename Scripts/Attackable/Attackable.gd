class_name Attackable
extends Node

signal on_damage_dealt(character: CharacterBase, damage: float)

@export var base_damage := 10.0
@export var multiplier := 1.0
var damage := base_damage * multiplier:
	get: return base_damage * multiplier

func update(_base_damage: float, _multiplier: float) -> void:
	self.base_damage = _base_damage
	self.multiplier = _multiplier

func deal_damange(character: CharacterBase) -> void:
	var previous_health := character.health
	character.health = max(0 , character.health - damage)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)

func deal_damange_delta(character: CharacterBase, delta: float) -> void:
	var damage_this_frame := damage * delta
	var previous_health := character.health
	character.health = max(0 , character.health - damage_this_frame)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)

func deal_damange_override(character: CharacterBase, new_damage: float) -> void:
	var previous_health := character.health
	character.health = max(0 , character.health - new_damage)
	if previous_health != character.health:
		on_damage_dealt.emit(character, damage)
