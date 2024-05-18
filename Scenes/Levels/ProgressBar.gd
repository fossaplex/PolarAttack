extends ProgressBar

@onready var progress_bar: ProgressBar = $"."
@onready var upgrade_menu: UpgradeMenu = $"../UpgradeMenu"
var _exp := 0

func _ready() -> void:
	visible = true
	upgrade_menu.on_upgrade_pressed.connect(on_upgrade_pressed)
	PlayerXpSignalBus.on_xp_increment.connect(on_xp_increment)

func on_xp_increment(xp: int, _prev_xp: int, max_xp: int) -> void:
	_exp = xp
	if max_xp != max_value:
		max_value = max_xp
	var tween := create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "value", float(xp) if xp != 0 else max_value, 1)

func on_upgrade_pressed(_modifier: Array[Modifier]) -> void:
	var tween := create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "value", 0,  1)
	if (_exp != 0) : tween.tween_property(self, "value", _exp,  1)
