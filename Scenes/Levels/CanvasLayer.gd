extends CanvasLayer

@onready var level_label: Label = $LevelLabel


func _ready() -> void:
	visible = true
	PlayerXpSignalBus.on_xp_increment.connect(on_xp_increment)
	
func on_xp_increment(xp: int, _prev_xp: int, _max_xp: int) -> void:
	level_label.text = str(xp, "/", _max_xp)
