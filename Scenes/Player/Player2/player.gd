class_name Player
extends Character

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var beam := $Projectiles/Beam as Beam
@onready var death_state = $FSM/DeathState
@onready var projectiles = $Projectiles
@onready var beam_attackable := $Projectiles/Beam/Attackable as Attackable
@onready var orbs = $Projectiles/Orbs
@onready var walk_state := $FSM/WalkState as PlayerWalkState

@export var orb_damage: float = 10:
	set(value):
		orb_damage = value
		if !is_node_ready(): return
		orbs.damage = orb_damage

@export var beam_damage: float = 10:
	set(value):
		beam_damage = value
		if !is_node_ready(): return
		beam_attackable.damage = beam_damage

func _ready():
	super()
	orb_damage = orb_damage
	beam_damage = beam_damage
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

func _set_speed(value: int) -> void:
	super(value)
	if !is_node_ready(): return
	walk_state.speed = speed 
	
signal is_dead

func _on_death_state_is_dead():
	is_dead.emit()
	projectiles.queue_free()
