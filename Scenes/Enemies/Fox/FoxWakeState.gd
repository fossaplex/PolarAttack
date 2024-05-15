class_name FoxWakeState
extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter() -> void:
	super()
	animated_sprite_2d.play("wake")
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation != "wake": return
	fsm.transition($"../FoxIdleState")
