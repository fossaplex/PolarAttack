class_name Orb
extends Area2D

const GROUPS = preload("res://Constants/Groups.gd")

@export var radius: float = 30
@export var speed: float = 200
@export var angle_offset := 0.0

@export var attackable : Attackable
@onready var audio_stream_player_2d := $AudioStreamPlayer2D as AudioStreamPlayer2D
@onready var audio_stream_player := $AudioStreamPlayer as AudioStreamPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const pitch_variation_range := 0.3
const base_pitch := 1.0
var angle_degrees := 0.0

func _ready() -> void:
	animated_sprite_2d.play("rotate")
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	angle_degrees += float(speed) * delta
	angle_degrees = fmod(angle_degrees, 360.0)

	var angle := deg_to_rad(angle_degrees + angle_offset)
	var x := radius * cos(angle)
	var y := radius * sin(angle)
	position = Vector2(x, y)
	audio_stream_player_2d.volume_db = linear_to_db(1)
	audio_stream_player_2d.pitch_scale = 1.0  / radius

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(GROUPS.ENEMY_HITBOX):
		if area is CharacterHitbox:
			attackable.deal_damange(area.character)
			var random_pitch := base_pitch + randf_range(-pitch_variation_range, pitch_variation_range) 
			audio_stream_player.pitch_scale = random_pitch
			audio_stream_player.play()
