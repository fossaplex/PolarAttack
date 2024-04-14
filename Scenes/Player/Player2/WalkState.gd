class_name WalkState
extends State

@export var animationPlayer: AnimationPlayer
@export var sprite: Sprite2D
@export var idle_state: IdleState
@export var player: CharacterBody2D
@export var speed: float

func enter() -> void:
	animationPlayer.play("walk")

func exit() -> void:
	pass

func process_frame(delta: float) -> void:
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	flip_sprite(horizontal_direction)

func process_physics(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !direction:
		state_transition.emit(idle_state)
		return
	player.velocity = direction * speed
	player.move_and_slide()

func flip_sprite(horizontal_direction: float) -> void:
	if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1
