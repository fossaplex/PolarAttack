class_name PlayerWalkState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var idle_state := $"../IdleState" as PlayerIdleState
@onready var player := $"../.." as Player
@onready  var speed: float = player.speed:
	get: return player.speed
@onready var sound_walk := $"../../SoundWalk" as AudioStreamPlayer2D
@onready var timer := $Timer as Timer

func enter() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = .2
	sound_walk.play()
	animation_player.play("walk")
	timer.start()

func exit() -> void:
	animation_player.stop()
	timer.stop()
	timer.timeout.disconnect(_on_timer_timeout)

func process_frame(_delta: float) -> void:
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	flip_sprite(horizontal_direction)

func process_physics(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !direction:
		fsm.transition_to(self, idle_state)
		return
	player.velocity = direction * speed
	player.move_and_slide()

func flip_sprite(horizontal_direction: float) -> void:
	if !player.is_beam_active and horizontal_direction != 0:
		sprite.flip_h = horizontal_direction == 1

func _on_timer_timeout() -> void:
	sound_walk.play()
