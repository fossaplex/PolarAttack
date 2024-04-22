extends Node2D

#region current values
@export var current_xp : int = 0
@export var current_level : int = 1
#endregion

#region max values
@export var max_xp : int = 100
#endregion

#The amount max xp increases everytime you level up
@export_range(0.0, 1.0, .01) var max_xp_intervel : float = .05

func _ready() -> void:
	CollectableSignalBus.xp_collected.connect(xp_collected)

func xp_collected(resource : BaseCollectableResource) -> void:
	current_xp += resource.experienceValue
	if current_xp >= max_xp:
		current_level += 1
		current_xp -= max_xp
		max_xp += int(max_xp_intervel) * int(max_xp)
		SignalBus.emit_player_leveled_up(max_xp, current_level)

	CollectableSignalBus.emit_update_xp_bar(current_xp)
