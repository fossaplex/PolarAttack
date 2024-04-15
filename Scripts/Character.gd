class_name Character
extends CharacterBody2D

@export var total_health: int = 100 : set = _set_total_health, get = _get_total_health
@export var health: int = 100 : set = _set_health, get = _get_health
@export var progress_bar: ProgressBar
@export var fsm :State

func _ready():
	total_health = total_health
	health = health

func _set_health(value: int) -> void:
	health = value
	if progress_bar:
		progress_bar.value = health

func _get_health() -> int:
	return health

func _set_total_health(value: int) -> void:
	total_health = value
	if progress_bar:
		progress_bar.max_value = total_health

func _get_total_health() -> int:
	return total_health

func _process(delta):
	if fsm: fsm.process_frame(delta)

func _physics_process(delta: float) -> void:
	if fsm: fsm.process_physics(delta)

func _input(event: InputEvent) -> void:
	if fsm: fsm.process_input(event)

func modify_queue_free():
	fsm = null
	queue_free()
