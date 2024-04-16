class_name CollectionHandler
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", on_area_entered)


func on_area_entered(area: Area2D) -> void:
	
	if area is BaseCollectableEntity:
		area.emit_signal("collect_entity")
	
