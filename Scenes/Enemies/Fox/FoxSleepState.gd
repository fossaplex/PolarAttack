class_name FoxSleepState
extends State

@onready var fox: Fox = $"../.."

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var sleep_area: SleepArea2D = $"../../SleepArea2D"
@onready var single_finite_state_machine: SingleFiniteStateMachine = $".."
@onready var fox_wake_state: Node = $"../FoxWakeState"

func enter() -> void:
	super()
	animated_sprite_2d.play("sleep")
	sleep_area.activate = true
	fox.on_health_change.connect(_on_health_change)

func exit() -> void:
	super()
	sleep_area.activate = false

func _on_health_change(health: int, prev_health: int) -> void:
	if not fox.setup_done: return
	if single_finite_state_machine._current_state != self: return
	if health <= prev_health:
		single_finite_state_machine.transition(fox_wake_state)
