class_name Orbs
extends Node2D

const orb_scenes = preload("res://Scenes/Orb/Orb.tscn")
@export var count = 3
@export var speed = 200

@export var damage: float = 10:
	set(value):
		damage = value
		if !is_node_ready(): return
		for orb in get_children():
			if orb is Orb:
				var att = orb.attackable
				orb.attackable.damage = damage
	
func _ready():
	damage = damage
	for i in range(count):
		var orb := orb_scenes.instantiate()
		orb.angle_offset = i * (360 / count)
		orb.speed = speed
		add_child(orb)
