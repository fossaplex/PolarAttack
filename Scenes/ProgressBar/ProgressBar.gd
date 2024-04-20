extends TextureProgressBar
class_name Generic_Progress_Bar

@export var progress_color = Color(0.0, 1.0, 0.0, 1.0) # Default color (Green)

func _ready() -> void:
	set_progress_color(progress_color)
	pass

func _process(delta):
	pass

# Increment function
func increment(increment_amount):
	value += increment_amount
	if value > max_value:
		value = max_value

func decrement(decrement_amount):
	value -= decrement_amount
	if value < min_value:
		value = 0

# Current XP Value getters and setters
func get_current_value():
	return value

func set_current_value(new_value):
	value = new_value

# Progress Color getters and setters
func get_progress_color():
	return progress_color

func set_progress_color(new_color):
	progress_color = new_color
	modulate = new_color
