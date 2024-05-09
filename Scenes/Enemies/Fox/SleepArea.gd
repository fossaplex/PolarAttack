class_name SleepArea2D
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sleep_range_2d: Sprite2D = $SleepRange
@onready var fox_wake_state: Node = $"../SingleFiniteStateMachine/FoxWakeState"

var circle_scale := 0.0
var circle_scale_modulate_a := 1.0
const SPRITE_MULTIPLER := 2.0
const AREA_MULTIPLER := 60.0

@export var sleep_range := 1.0:
	set(value):
		sleep_range = value
		if not is_node_ready(): return
		sleep_range_2d.scale.x = sleep_range * SPRITE_MULTIPLER
		sleep_range_2d.scale.y = sleep_range * SPRITE_MULTIPLER
		var shape := collision_shape_2d.shape as CircleShape2D
		shape.radius = AREA_MULTIPLER * sleep_range

@export var activate := true:
	set(value):
		activate = value
		sleep_range_2d.visible = activate
		set_deferred("monitoring", activate)

func _ready() -> void:
	sleep_range = sleep_range
	activate = activate

func _process(delta: float) -> void:
	if not activate: return
	circle_scale += delta * sleep_range * SPRITE_MULTIPLER
	sleep_range_2d.scale.x = circle_scale
	sleep_range_2d.scale.y = circle_scale
	sleep_range_2d.modulate.a = 1 - (circle_scale / (sleep_range * SPRITE_MULTIPLER))
	if circle_scale > sleep_range * 2:
		circle_scale = 0

