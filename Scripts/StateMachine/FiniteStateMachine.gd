class_name FiniteStateMachine
extends State

func has_current_state() -> bool:
	return false

func transition(destination_state : State) -> State:
	return null

func transition_to(source_state: State, destination_state : State) -> State:
	return null

func add_transition_to(source_state: State, destination_state: State, append: bool, remove_source: bool) -> State:
	return null
