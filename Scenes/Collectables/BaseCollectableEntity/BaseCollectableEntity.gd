extends Area2D
class_name BaseCollectableEntity

@export var collectable_resource : BaseCollectableResource:
	set(value):
		collectable_resource = value
		if collectable_resource.collectable_texture and is_node_ready():
			animated_sprite_2d.sprite_frames = collectable_resource.collectable_texture
			animated_sprite_2d.play()



@onready var animated_sprite_2d = $AnimatedSprite2D


signal collect_entity


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("collect_entity", on_collect)
	#collectable_resource = collectable_resource
	#sprite_2d.texture = collectable_resource.collectable_texture
	
func on_collect() -> void:
	CollectableSignalBus.emit_collect_entity(collectable_resource)
	queue_free()
	
