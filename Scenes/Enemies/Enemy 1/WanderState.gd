class_name SealWanderState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var seal := $"../.." as Seal
@onready var timer := $Timer as Timer
@onready var speed: int = seal.speed:
	get: return seal.speed
@onready var sprite: Sprite2D = $"../../Sprite2D"

var velocity := Vector2.ZERO

func enter() -> void:
	super()
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	animation_player.play("walk")

func exit() -> void:
	super()
	timer.timeout.disconnect(_on_timer_timeout)

func process_frame(delta: float) -> void:
	super(delta)
	if seal.velocity.x != 0:
		sprite.flip_h = seal.velocity.x > 0

func process_physics(delta: float) -> void:
	super(delta)
	seal.velocity = velocity
	seal.move_and_slide()

func _on_timer_timeout() -> void:
	var random_angle := randf() * 2 * PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * speed
