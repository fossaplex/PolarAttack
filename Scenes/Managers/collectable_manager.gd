extends Node
class_name CollectableManager

var current_experience_count: int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	CollectableSignalBus.connect("collect_entity", on_entity_collected)
	
	
func on_entity_collected(collectable_resource: BaseCollectableResource):
	match collectable_resource.collectable_type:
		"":
			return
		"experience":
			#current_experience_count += collectable_resource.experienceValue
			CollectableSignalBus.emit_on_xp_collected(collectable_resource)

			
