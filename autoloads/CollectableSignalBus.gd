extends Node

signal collect_entity(collectable_entity_resource: BaseCollectableEntity)

#region collectable type signals
signal xp_collected(collectable_entity_resource: BaseCollectableEntity)
#endregion

#region UI update signals
signal on_update_xp_bar(value : int)
#endregion




func emit_collect_entity(collectable_entity_resource: BaseCollectableResource) -> void:
	collect_entity.emit(collectable_entity_resource)

func emit_on_xp_collected(collectable_entity_resource: BaseCollectableResource) -> void:
	xp_collected.emit(collectable_entity_resource)
	
func emit_update_xp_bar(value: int) -> void:
	on_update_xp_bar.emit(value)
	

