class_name PlayerXpHandler
extends Node

#region current values
@export var current_xp : int = 0:
	set(value):
		if current_xp == value: return
		var prev_xp := current_xp
		current_xp = value
		PlayerXpSignalBus.on_xp_increment.emit(current_xp, prev_xp, max_xp)

@export var current_level : int = 1:
	set(value):
		if current_level == value: return
		var prev_level := current_level
		current_level = value
		current_xp = 0
		PlayerXpSignalBus.on_level_change.emit(current_level, prev_level)
#endregion

#region 
@export var max_xp : int:
	get: return xp_function()
@export var base_xp : int = 100
@export var increments: int = 20
#endregion

func _ready() -> void:
	CollectableSignalBus.xp_collected.connect(xp_collected)
	current_level = current_level
	current_xp = current_xp

func xp_collected(resource : BaseCollectableResource) -> void:
	current_xp += resource.experienceValue
	if current_xp >= max_xp:
		current_level += 1

func xp_function() -> int:
	return base_xp + (current_level - 1) * increments
		
