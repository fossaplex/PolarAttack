class_name Seal
extends Character

@onready var walk_state := $FSM/WalkState as SealWlakState
@onready var wander_state := $FSM/WanderState as SealWanderState
@onready var death_state := $FSM/DeathState as State
@onready var concrete_fsm := fsm as FiniteStateMachine
@onready var attackable = $Hitbox/Attackable

@export var damage: float = 10:
	set(value):
		damage = value
		if !is_node_ready(): return
		attackable.damage = damage

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
	damage = damage

func _set_health(value: int) -> void:
	super(value)
	if (concrete_fsm and health == 0):
		concrete_fsm.transition_to(fsm.current_state, death_state)

func _set_speed(value: int) -> void:
	super(value)
	if !is_node_ready(): return
	walk_state.speed = speed 
	
