extends CanvasLayer

@onready var level_label: Label = $LevelLabel

@onready var player: Player = $"../Player"
@onready var health_progress_bar: ProgressBar = $HealthProgressBar
@onready var health_label: Label = $HealthLabel

func _ready() -> void:
	visible = true
	player.on_health_change.connect(_on_health_change)
	player.on_total_health_change.connect(_on_total_health_change)
	health_progress_bar.value = player.health
	health_progress_bar.max_value = player.total_health
	var player_xp_handler := player.player_xp_handler 
	level_label.text = str("Level: ", player_xp_handler.current_level ," - XP:" , player_xp_handler.current_xp, "/", player_xp_handler.max_xp)
	PlayerXpSignalBus.on_xp_increment.connect(on_xp_increment)

func _process(_delta: float) -> void:
	health_label.text = str(ceil(player.health)," / ", player.total_health)

func on_xp_increment(xp: int, _prev_xp: int, _max_xp: int) -> void:
	level_label.text = str("Level: ", player.player_xp_handler.current_level ," - XP:" , xp, "/", _max_xp)

func _on_health_change(health: float, _prev_health: float) -> void:
	health_progress_bar.value = health

func _on_total_health_change(total_health: int, _prev_total_health: int) -> void:
	health_progress_bar.max_value = total_health
