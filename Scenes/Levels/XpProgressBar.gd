extends TextureProgressBar

func _ready() -> void:
	visible = true
	PlayerXpSignalBus.on_xp_increment.connect(on_xp_increment)

func on_xp_increment(xp: int, _prev_xp: int, max_xp: int) -> void:
	value = xp
	max_value = max_xp
