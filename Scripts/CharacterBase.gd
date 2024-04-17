class_name CharacterBase
extends CharacterBody2D

#region Base Stat
@export var base_total_health: int = 100
@export var base_speed: int = 100

#endregion

#region stats
var total_health: int = 100 : set = _set_total_health, get = _get_total_health
var speed: int = 200: set = _set_speed, get = _get_speed
var health: int = total_health : set = _set_health
#endregion

#region stat multiplier
@export var speed_multiplier: float = 1
@export var total_health_multiplier: float = 1
#endregions

@export var fsm :State = null

signal on_total_health_change(total_health: int, prev_total_health: int)
signal on_health_change(health: int, prev_health: int)
signal on_dead(prev_health: int)
signal on_speed_change(speed: int, prev_spreed: int)

func _ready():
	total_health = total_health
	health = total_health
	speed = speed

func _process(delta):
	if fsm: fsm.process_frame(delta)

func _physics_process(delta: float) -> void:
	if fsm: fsm.process_physics(delta)

func _input(event: InputEvent) -> void:
	if fsm: fsm.process_input(event)

func character_queue_free():
	fsm = null
	queue_free()

func _set_total_health(value: int) -> void:
	var prev = total_health
	total_health = value

	if prev != total_health:
		on_total_health_change.emit(prev, total_health)
	if health > total_health:
		health = total_health

func _get_total_health() -> int:
	return base_total_health * total_health_multiplier

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

func _get_speed() -> int:
	return base_speed * speed_multiplier

