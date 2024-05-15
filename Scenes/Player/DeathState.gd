class_name PlayerDeathState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var player := $"../.." as Player
@onready var GAME_OVER_SCENE := preload("res://Scenes/GameOver/game_over_scene.tscn") as PackedScene

signal is_dead

func enter() -> void:
	super()
	animation_player.play("death")
	is_dead.emit()
	SceneTransition.change_scene(GAME_OVER_SCENE, "packed")

func process_physics(delta: float) -> void:
	super(delta)
	player.velocity = Vector2.ZERO
	player.move_and_slide()
