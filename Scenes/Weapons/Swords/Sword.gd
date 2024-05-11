class_name Sword
extends Area2D

const GROUPS = preload("res://Constants/Groups.gd")
var attackable : Attackable
var direction: Vector2
var once := false
var time := 0.0
var speed := 100.0
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func() -> void: queue_free())
	area_entered.connect(on_area_entered)

func _process(delta: float) -> void:
	if not direction: return
	position += direction * speed * delta

func launch(_direction: Vector2, angle: float) -> void:
	direction = _direction
	rotate(angle)

func on_area_entered(area: Area2D) -> void:
	if area.is_in_group(GROUPS.ENEMY_HITBOX):
		if area is CharacterHitbox:
			attackable.deal_damange(area.character)
	queue_free()
