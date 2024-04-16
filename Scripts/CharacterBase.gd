class_name CharacterBase
extends CharacterBody2D

@export var total_health: int = 100 : set = _set_total_health
@export var health: int = 100 : set = _set_health
@export var speed: int = 200 : set = _set_speed
@export var fsm :State = null

signal on_total_health_change(total_health: int, prev_total_health: int)
signal on_health_change(health: int, prev_health: int)
signal on_dead(prev_health: int)
signal on_speed_change(speed: int, prev_spreed: int)

func _ready():
	total_health = total_health
	health = health
	speed = speed

func _process(delta):
	if fsm: fsm.process_frame(delta)

func _physics_process(delta: float) -> void:
	if fsm: fsm.process_physics(delta)

func _input(event: InputEvent) -> void:
	if fsm: fsm.process_input(event)

func charachter_queue_free():
	fsm = null
	queue_free()
	
func _set_total_health(value: int) -> void:
	var prev = total_health
	total_health = value

	if prev != total_health:
		on_total_health_change.emit(prev, total_health)

	health = min(health, total_health)

func _set_health(value: int) -> void:
	var prev = health
	health = value
	
	if prev != health:
		on_health_change.emit(prev, health)
		if health <= 0: 
			on_dead.emit(prev)

func _set_speed(value: int) -> void:
	var prev = speed
	speed = value
	
	if prev != speed:
		on_speed_change.emit(prev, speed)


