extends Area2D

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is BaseCollectableEntity:
		area.on_collect()
