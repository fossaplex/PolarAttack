extends Node2D

const orb_scenes = preload("res://Scenes/Orb/Orb.tscn")
@export var count = 3
@export var speed = 200
	
func _ready():
	for i in range(count):
		var orb := orb_scenes.instantiate()
		orb.angle_offset = i * (360 / count)
		orb.speed = speed
		add_child(orb)
