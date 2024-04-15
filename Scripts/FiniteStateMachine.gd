@icon("res://Icons/FSMSprite.png")
extends State
class_name FiniteStateMachine

var current_state : State
@export var initial_state : State

#NOTE This is a generic finite_state_machine, it handles all states, changes to this code will affect
	# everything that uses a state machine!

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.request_transition_to.connect(transition_to)

	if initial_state:
		current_state = initial_state
		initial_state.enter()

func transition_to(source_state: State, destination_state : State) -> void:
	if source_state and source_state != current_state:
		return
	if destination_state == current_state:
		return

	current_state.exit()

	current_state = destination_state
	current_state.enter()
	
func process_physics(delta: float) -> void:
	current_state.process_physics(delta)
	
func process_frame(delta: float) -> void:
	current_state.process_frame(delta)

func process_input(event: InputEvent) -> void:
	current_state.process_input(event)
