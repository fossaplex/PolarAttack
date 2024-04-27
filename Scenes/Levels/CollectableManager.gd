extends Node
class_name CollectableManager

var current_experience_count: int = 0

func _ready() -> void:
	CollectableSignalBus.collect_entity.connect(on_entity_collected)

func on_entity_collected(collectable_resource: BaseCollectableResource) -> void:
	match collectable_resource.collectable_type:
		"":
			return
		"experience":
			CollectableSignalBus.xp_collected.emit(collectable_resource)
