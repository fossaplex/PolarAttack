class_name SealWanderState
extends State



@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var seal := $"../.." as Seal
@onready var timer := $Timer as Timer
@onready var speed: int = seal.speed:
	get: return seal.speed
	
var velocity := Vector2.ZERO

func enter() -> void:
	timer.start()
	animation_player.play("walk")

func process_physics(delta: float) -> void:
	seal.velocity = velocity 
	seal.move_and_slide()

func _on_timer_timeout():
	var random_angle = randf() * 2 * PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * speed
