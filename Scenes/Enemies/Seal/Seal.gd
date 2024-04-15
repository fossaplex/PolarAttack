class_name Seal
extends Character

@onready var walk_state := $FSM/WalkState as SealWlakState
@onready var wander_state := $FSM/WanderState as SealWanderState
@onready var death_state := $FSM/DeathState as State
@onready var concrete_fsm := fsm as FiniteStateMachine

@export var target: Character = null:
	set(value):
		target = value
		if !is_node_ready(): return
		if target:
			walk_state.target = value
		else:
			concrete_fsm.transition_to(concrete_fsm.current_state, wander_state)

func _ready():
	super()
	target = target

func _set_health(value: int) -> void:
	super(value)
	if (concrete_fsm and health == 0):
		concrete_fsm.transition_to(fsm.current_state, death_state)
