class_name Weapon
extends Node2D

var attackable: Attackable

func _ready() -> void:
	for child in get_children():
		if !(child is Attackable): continue
		attackable = child
		break
