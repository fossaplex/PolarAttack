class_name IFrame
extends Node

@export var character: CharacterBase

@export var is_invincible := false:
	set(value):
		if value and is_iframe_cd_active:
			is_iframe_cd_active = true
			return
		is_invincible = value
		if is_invincible:
			is_iframe_cd_active = true
			i_frame_timer.start()
			_on_i_frame_timer_timeout()
		else:
			i_frame_current_count = 0
			character.modulate.v = 1
			character.modulate.a = 1
			i_frame_timer.stop()

@export var is_iframe_cd_active := false:
	set(value):
		if value:
			i_frame_cd_timer.start()
		elif not value and not i_frame_cd_timer.is_stopped():
			i_frame_cd_timer.stop()
	get: 
		return i_frame_cd_timer.time_left > 0

@onready var i_frame_timer: Timer = $IFrameTimer
@export var i_frame_max_count  := 10
var i_frame_current_count  := 0
@onready var i_frame_cd_timer: Timer = $IFrameCdTimer

func _ready() -> void:
	i_frame_timer.timeout.connect(_on_i_frame_timer_timeout)
	i_frame_cd_timer.timeout.connect(_on_i_frame_cd_timer_timeout)

func _on_i_frame_timer_timeout() -> void:
	character.modulate.v = 15 if character.modulate.v == 1 else 1
	character.modulate.a = 0.25 if character.modulate.a == 1 else 1
	if i_frame_current_count >= i_frame_max_count or character.health <= 0:
		is_invincible = false
	i_frame_current_count += 1

func _on_i_frame_cd_timer_timeout() -> void:
	i_frame_cd_timer.stop()
