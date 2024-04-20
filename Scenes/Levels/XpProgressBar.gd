extends TextureProgressBar




func _ready() -> void:
	visible = true
	CollectableSignalBus.on_update_xp_bar.connect(update_xp_bar)
	SignalBus.on_update_max_xp_bar.connect(update_max_xp_bar)

func update_xp_bar(new_xp_value : int) -> void:
	value = new_xp_value

func update_max_xp_bar(new_max_xp_value : int) -> void:
	max_value = new_max_xp_value
