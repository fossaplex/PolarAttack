extends Node2D
var seal_scene = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")

func _ready():
	$Timer.start()

func _on_timer_timeout():
	var enemy_seal: Node2D = seal_scene.instantiate()
	add_child(enemy_seal)
