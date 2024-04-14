extends Node

#Gui Signals
signal rebind_button_toggled(value: bool)

func emit_rebind_button_toggled(value: bool) -> void:
	rebind_button_toggled.emit(value)

signal collect_entity(collectable_entity_resource: BaseCollectableEntity)

func emit_collect_entity(collectable_entity_resource: BaseCollectableResource):
	collect_entity.emit(collectable_entity_resource)

