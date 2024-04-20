extends Node

signal on_update_max_xp_bar(value : int)

signal on_update_current_level_label(value : int)

signal on_open_upgrade_menu()

func emit_player_leveled_up(max_xp: int, current_level: int) -> void:
	on_update_max_xp_bar.emit(max_xp)
	on_update_current_level_label.emit(current_level)
	on_open_upgrade_menu.emit()

