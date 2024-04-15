extends Node2D

#region current values
@export var current_xp : int = 0
@export var current_level : int = 0
#endregion

#region max values
@export var max_xp : int = 100
#endregion

#The amount max xp increases everytime you level up
@export_range(0.0, 1.0, .01) var max_xp_intervel : float = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	CollectableSignalBus.xp_collected.connect(xp_collected)
	
func xp_collected(resource : BaseCollectableResource):
	current_xp += resource.experienceValue
	if current_xp > max_xp:
		current_level += 1
		current_xp -= max_xp
		max_xp += (max_xp_intervel * max_xp)
		CollectableSignalBus.emit_player_leveled_up(max_xp, current_level)
		
	CollectableSignalBus.emit_update_xp_bar(current_xp)
	
