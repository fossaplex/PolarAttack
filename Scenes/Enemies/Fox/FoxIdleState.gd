class_name FoxIdleState
extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var sleep_area_2d: SleepArea2D = $"../../SleepArea2D"
@onready var fox: Fox = $"../.."

func enter() -> void:
	super()
	if (fsm as SingleFiniteStateMachine)._current_state == self:
		animated_sprite_2d.play("idle")
		if not fox.target:
			sleep_area_2d.activate =  true
			sleep_area_2d.sleep_range = 3

func exit() -> void:
	super()
	sleep_area_2d.activate =  false
	sleep_area_2d.sleep_range = 1
