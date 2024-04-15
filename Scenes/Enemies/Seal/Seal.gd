extends Character

@onready var walk_state := $FSM/WalkState as SealWlakState
@onready var attack_state := $FSM/AttackState as SealAttackState
@onready var death_state := $FSM/DeathState as State

@export var target: Character = null :
	set(value):
		target = value
		if is_node_ready():
			walk_state.target = value
			attack_state.target = value

func _ready():
	super()
	target = target

func _set_health(value: int) -> void:
	super(value)
	if (health == 0):
		fsm.transition_to(fsm.current_state, death_state)
