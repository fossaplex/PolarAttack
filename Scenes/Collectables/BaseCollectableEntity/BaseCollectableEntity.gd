extends Area2D
class_name BaseCollectableEntity
@onready var timer: Timer = $Timer

@export var collectable_resource : BaseCollectableResource:
	set(value):
		collectable_resource = value
		if collectable_resource.collectable_texture and is_node_ready():
			animated_sprite_2d.sprite_frames = collectable_resource.collectable_texture
			animated_sprite_2d.play()

@onready var animated_sprite_2d := $AnimatedSprite2D

func on_collect() -> void:
	CollectableSignalBus.collect_entity.emit(collectable_resource)
	queue_free()

func _ready() -> void:
	var tween := create_tween()
	var tween_duration := .4
	
	tween.tween_property(self, "position", Vector2(0, -10), tween_duration).as_relative().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "position", Vector2(0, 10), tween_duration).as_relative()
	

	timer.timeout.connect(
		
		func() -> void: queue_free()
	)

func _process(_delta: float) -> void:
	var alpha := timer.time_left/timer.wait_time
	animated_sprite_2d.modulate.a = alpha
