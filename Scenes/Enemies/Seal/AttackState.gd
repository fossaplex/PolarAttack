class_name SealWanderState
extends State

var animation_player: AnimationPlayer
var seal: Character
@onready var timer := $Timer as Timer
var velocity := Vector2.ZERO
var speed: int = 100

func enter() -> void:
	timer.start()
	animation_player.play("walk")

func process_physics(delta: float) -> void:
	seal.velocity = velocity 
	seal.move_and_slide()


func _on_timer_timeout():
	var random_angle = randf() * 2 * PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * speed
