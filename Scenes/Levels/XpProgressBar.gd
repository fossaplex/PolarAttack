extends TextureProgressBar




# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	CollectableSignalBus.on_update_xp_bar.connect(update_xp_bar)
	CollectableSignalBus.on_update_max_xp_bar.connect(update_max_xp_bar)


func update_xp_bar(new_xp_value : int):
	value = new_xp_value
	
func update_max_xp_bar(new_max_xp_value : int):
	max_value = new_max_xp_value
