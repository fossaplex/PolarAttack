extends FiniteStateMachine

func process_input(event: InputEvent) -> void:
	current_state.process_input(event)
	if event is InputEventMouseButton:
		if event.is_action_pressed("primary_attack") and event.is_pressed():
			transition_to($AttackState)
		else:
			transition_to($IdleState)
