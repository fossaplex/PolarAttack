class_name FiniteStateMachine
extends State

func has_current_state() -> bool:
	return false

func transition(_destination_state : State) -> State:
	return null

func transition_to(_source_state: State, _destination_state : State) -> State:
	return null

func add_transition_to(_source_state: State, _destination_state: State, _append: bool, _remove_source: bool) -> State:
	return null
