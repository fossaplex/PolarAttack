class_name Orbs
extends Weapon

const orb_scenes := preload("res://Scenes/Orb/Orb.tscn")
@export var count := 3
@export var speed := 200

func _ready() -> void:
	super()
	for i in range(count):
		var orb := orb_scenes.instantiate()
		orb.attackable = attackable
		orb.angle_offset = i * (360.0 / count)
		orb.speed = speed
		add_child(orb)
