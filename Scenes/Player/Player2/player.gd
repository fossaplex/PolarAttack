extends Character

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var beam := $projectiles/Beam as Beam
@onready var death_state = $FSM/DeathState
@onready var projectiles = $projectiles

func _ready():
	super()
	beam.visible = false
	var material := sprite.material
	if material is ShaderMaterial:
		material.set_shader_parameter("hit_opacity", 0)

func _set_health(value: int) -> void:
	#if (health > value):
		#animation_player.play("hit")
	super(value)

	if health <= 0:
		var concreate_fsm := fsm as FiniteStateMachine
		concreate_fsm.transition_to(concreate_fsm.current_state, death_state)

signal is_dead

func _on_death_state_is_dead():
	is_dead.emit()
	projectiles.queue_free()

	
