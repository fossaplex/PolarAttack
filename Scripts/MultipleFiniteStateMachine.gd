@icon("res://Icons/FSMSprite.png")
extends State
class_name MultipleFiniteStateMachine

var current_states : Array[State]
@export var initial_states : Array[State]

#NOTE This is a generic finite_state_machine, it handles all states, changes to this code will affect
	# everything that uses a state machine!

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.request_transition_to.connect(transition_to)
			child.request_add_transition_to.connect(add_transition_to)

	current_states = initial_states
	for state in current_states:
		state.enter()

func transition_to(source_state: State, destination_state: State) -> void:
	for current_state in current_states:
		if current_state != destination_state:
			current_state.exit()
	
	current_states = [destination_state]
	destination_state.enter()

func add_transition_to(source_state: State, destination_state: State, append: bool, remove_source: bool) -> void:
	if append:
		if remove_source and source_state:
			var index = current_states.find(source_state)
			if (index != -1):
				source_state.exit()
				current_states.remove_at(index)
		if !current_states.has(destination_state):
			current_states.append(destination_state)
			destination_state.enter()
	else:
		transition_to(source_state, destination_state)
	
func process_physics(delta: float) -> void:
	for state in current_states:
		state.process_physics(delta)

func process_frame(delta: float) -> void:
	print(current_states)
	for state in current_states:
		state.process_frame(delta)

func process_input(event: InputEvent) -> void:
	for state in current_states:
		state.process_input(event)
