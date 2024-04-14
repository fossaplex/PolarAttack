@icon("res://Icons/StateSprite.png")
extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic
# DO NOT CHANGE THIS unless you know what you are doing

signal state_transition(state: State)

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process_physics(_delta: float) -> void:
	pass

func process_input(_event: InputEvent) -> void:
	pass

func process_frame(_delta: float) -> void:
	pass
