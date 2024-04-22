class_name Orbs
extends Weapon

const orb_scenes := preload("res://Scenes/Orb/Orb.tscn")
var orbs: Array:
	get: return get_children().filter(func(it: Variant) -> bool: return it is Orb)

@export var count := 4:
	set(value):
		if !is_node_ready(): return
		print("i",count, value)
		if value >= count:
			print("-",max(0, orbs.size()), value)
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
