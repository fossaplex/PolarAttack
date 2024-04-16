extends SingleFiniteStateMachine

@onready var attack_state := $AttackState as PlayerAttackState
@onready var idle_state := $IdleState as PlayerIdleState
@onready var death_state := $DeathState as PlayerDeathState

func process_input(event: InputEvent) -> void:
	super(event)
	if event is InputEventMouseButton:
		if event.is_action_pressed("primary_attack") and event.is_pressed():
			transition(attack_state)
		else:
			transition(idle_state)

func transition(destination_state : State) -> State:
	if (_current_state == death_state):
		return null
	return super(destination_state)
