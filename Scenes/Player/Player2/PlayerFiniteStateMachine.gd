extends FiniteStateMachine
	
func process_input(event: InputEvent) -> void:
	super(event)
	if event is InputEventMouseButton:
		if event.is_action_pressed("primary_attack") and event.is_pressed():
			transition_to(current_state, $AttackState)
		else:
			transition_to(current_state, $IdleState)

