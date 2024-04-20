class_name CollectionHandler
extends Area2D

func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(area: Area2D) -> void:
	
	if area is BaseCollectableEntity:
		area.emit_signal("collect_entity")
	
