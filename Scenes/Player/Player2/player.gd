extends Character

var MOVE_SPEED: float = 100.0
@onready var fsm := $FSM as FiniteStateMachine

func _ready():
	$Beam.visible = false

func _process(delta):
	fsm.process_frame(delta)

func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)

func _input(event: InputEvent) -> void:
	fsm.process_input(event)
