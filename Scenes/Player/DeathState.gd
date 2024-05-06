class_name PlayerDeathState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var player := $"../.." as Player


signal is_dead

func enter() -> void:
	animation_player.play("death")
	is_dead.emit()
	handle_player_stats()
	SceneTransition.change_scene("res://Scenes/GameOver/game_over_scene.tscn", "file")
	
	
func handle_player_stats() -> void:

	GameStats.player_level = player.get_player_level()
	
func process_physics(_delta: float) -> void:
	player.velocity = Vector2.ZERO
	player.move_and_slide()
