extends Node2D
var seal_scence = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
 
func _ready():
	$Timer.start()

func _on_timer_timeout():
	var seal: CharacterBody2D = seal_scence.instantiate()
	add_child(seal)
