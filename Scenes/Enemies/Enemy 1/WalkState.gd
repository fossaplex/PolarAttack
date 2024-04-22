class_name WalkState
extends State
const GROUPS = preload("res://Constants/Groups.gd")

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var seal := $"../.." as Seal
@onready var target: CharacterBase = seal.target:
	get: return seal.target
@onready var attackable: Attackable = seal.attackable:
	get: return seal.attackable
@export var speed: int = 100:
	get: return seal.speed
@onready var hit_box := $"../../HitBox" as CharacterHitbox
var _is_damaging := false

func _ready() -> void:
	hit_box.area_entered.connect(_on_hit_box_area_entered)
	hit_box.area_exited.connect(_on_hit_box_area_exited)

func enter() -> void:
	animation_player.play("walk")

func exit() -> void:
	animation_player.stop()
	seal.velocity = Vector2.ZERO

func process_frame(delta: float) -> void:
	if seal.velocity.x != 0:
		sprite.flip_h = seal.velocity.x > 0
	if _is_damaging:
		attackable.deal_damange_delta(target, delta)

func process_physics(_delta: float) -> void:
	var direction := (target.global_position - seal.global_position).normalized()
	seal.velocity = direction * speed
	seal.move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if !area.is_in_group(GROUPS.PLAYER_HITBOX): return
	if !area is CharacterHitbox : return
	if area.character != target: return
	_is_damaging = true

func _on_hit_box_area_exited(area: Area2D) -> void:
	if !area.is_in_group(GROUPS.PLAYER_HITBOX): return
	_is_damaging = false
