extends Node2D

@export var total_health := 16
@export var heart_width := 5
@export var padding := 2
var current_health := total_health
var total_hearts := ceil(total_health / 2.0) as float
var heart_scene := preload("res://Scenes/Hearts/Heart/Heart.tscn")

var hearts = []

	

func _ready() -> void:
	for i in range(total_hearts):
			var heart_instance := heart_scene.instantiate()
			add_child(heart_instance)
			hearts.append(heart_instance)
			var x_position := i * (heart_width + padding)
			heart_instance.position = Vector2(x_position, 0)
	set_health(total_health)
		# Position the hearts appropriately here

func set_health(health_points):
	var total_points = health_points
	for heart in hearts:
		if total_points >= 2:
			heart.set_heart_state(2)
			total_points -= 2
		elif total_points == 1:
			heart.set_heart_state(1)
			total_points -= 1
		else:
			heart.set_heart_state(0)
			
func get_health():
	return current_health
	
func subtract_health(value):
	current_health -= value 
	set_health(current_health)

func add_health(value):
	current_health += value 
	set_health(current_health)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
