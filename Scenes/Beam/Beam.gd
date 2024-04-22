class_name Beam
extends Weapon

const GROUPS := preload("res://Constants/Groups.gd")

const MAX_LENGTH := 2000

@onready var beam := $Beam as Sprite2D
@onready var begin := $Begin as Sprite2D 
@onready var end := $End as Node2D
@onready var raycast := $RayCast2D as RayCast2D

var active_last_frame := false
func _ready() -> void:
	super()
	visible = false

signal on_beam_active(is_active: bool, horizontal_direction: float)

func _physics_process(_delta: float) -> void:
	var mouse_position := get_local_mouse_position()
	var max_cast_to := mouse_position.normalized() * MAX_LENGTH
	raycast.target_position = max_cast_to
	if raycast.is_colliding():
		end.global_position = raycast.get_collision_point()
	else:
		end.global_position = raycast.target_position
	beam.rotation = raycast.target_position.angle()
	beam.region_rect.end.x = end.position.length()

func _process(delta: float) -> void:
	var node := raycast.get_collider()
	if node is CharacterHitbox and node.is_in_group(GROUPS.ENEMY_HITBOX):
		attackable.deal_damange_delta(node.character, delta)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("primary_attack"):
		active_last_frame = true
		visible = true
		raycast.collide_with_areas = true
		var direction := raycast.target_position.direction_to(begin.global_position).normalized()
		on_beam_active.emit(true, direction.x)
	elif active_last_frame:
		active_last_frame = false
		visible = false
		raycast.collide_with_areas = false
		on_beam_active.emit(false, 0)


