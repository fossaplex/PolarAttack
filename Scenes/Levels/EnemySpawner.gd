extends Node2D

const seal_scenes =  preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")

var markers: Array[Marker2D] = []

@onready var timer = $Timer
@onready var spawn_points = $SpawnPoints
@onready var player := $"../Player" as Player
@onready var seals = $"../Seals"

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	timer.wait_time = 10
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timer_timeout():
	for spawn_point in spawn_points.get_children():
		if spawn_point is Marker2D:
			var seal := seal_scenes.instantiate()
			
			seals.add_child(seal)
			seal.target = player
			seal.attackable.damage = 1
			seal.global_position = spawn_point.global_position
