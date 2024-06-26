class_name CharacterBase
extends CharacterBody2D

#region base stat
@export var base_total_health: int = 1: set = _base_total_health
@export var base_speed: int = 100
#endregion

#region stats
var total_health: int = 1 :
	get: return int(base_total_health) * int(total_health_multiplier)
var speed: int = 200: set = _set_speed, get = _get_speed
var health: float = total_health : set = _set_health
#endregion

#region stat multiplier
@export var speed_multiplier: float = 1
@export var total_health_multiplier: float = 1
#endregions

@export var fsm :State = null

signal on_total_health_change(total_health: int, prev_total_health: int)
signal on_health_change(health: float, prev_health: float)
signal on_dead(prev_health: float)
signal on_speed_change(speed: int, prev_spreed: int)

func _ready() -> void:
	base_total_health = base_total_health
	total_health = total_health
	health = total_health
	speed = speed

func character_queue_free() -> void:
	fsm = null
	queue_free()

func _base_total_health(value: int) -> void:
	var prev := base_total_health
	base_total_health = value
	if prev != base_total_health: 
		on_total_health_change.emit(base_total_health, prev)

func _set_health(value: float) -> void:
	var prev := health
	health = minf(value, total_health)
	
	if prev != health:
		on_health_change.emit(health, prev)
		if health <= 0: 
			on_dead.emit(prev)

func _set_speed(value: int) -> void:
	var prev := speed
	speed = value
	
	if prev != speed:
		on_speed_change.emit(speed, prev)

func _get_speed() -> int:
	return int(base_speed * speed_multiplier)

