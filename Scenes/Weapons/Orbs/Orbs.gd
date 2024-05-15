class_name Orbs
extends Weapon
const Weapon = preload("res://Scripts/Weapon.gd")
const orb_scenes := preload("res://Scenes/Weapons/Orbs/Orb.tscn")
var orbs: Array:
	get: return get_children().filter(func(it: Variant) -> bool: return it is Orb)

@export var count := 1:
	set(value):
		if !is_node_ready(): return
		if value >= count:
			for i in range(max(0, orbs.size()), value):
				var orb := orb_scenes.instantiate()
				add_child(orb)
				orb.attackable = attackable
		else:
			for i in range(value, orbs.size()):
				var node := get_children().pop_back() as Orb
				node.queue_free()
		for orb: Orb in orbs:
			var i := orbs.find(orb)
			orb.angle_offset = 0
			orb.angle_offset = i * (360.0 / orbs.size())
		count = value

@export var speed := 200:
	set(value):
		speed = value
		for orb: Orb in orbs:
			orb.speed = value
		for orb: Orb in orbs:
			var i := orbs.find(orb)
			orb.angle_offset = 0
			orb.angle_offset = i * (360.0 / orbs.size())

func _ready() -> void:
	super()
	count = count
	speed = speed
