extends Node2D

class_name Level

signal toggle_game_paused(is_paused : bool)
@onready var player := $Player as Player
@onready var timer := $EnemySpawner/Timer as Timer
@onready var seals = $Seals

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)
func _ready() -> void:
	player.on_dead.connect(_on_player_on_dead)

func _input(event : InputEvent):
	if event.is_action_pressed("esc"):
		game_paused = !game_paused

func _on_player_on_dead(_prev_health):
	timer.stop()
	for seal in seals.get_children():
		if seal is Seal:
			seal.target = null
