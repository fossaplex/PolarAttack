extends Area2D
class_name BaseCollectableEntity

@export var collectable_resource : BaseCollectableResource


@onready var sprite_2d = $Sprite2D


signal collect_entity


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("collect_entity", on_collect)
	sprite_2d.texture = collectable_resource.collectable_texture
	
func on_collect() -> void:
	SignalBus.emit_collect_entity(collectable_resource)
	queue_free()
	
