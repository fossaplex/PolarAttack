extends Node

signal collect_entity(collectable_entity_resource: BaseCollectableEntity)


func emit_collect_entity(collectable_entity_resource: BaseCollectableResource):
	collect_entity.emit(collectable_entity_resource)

