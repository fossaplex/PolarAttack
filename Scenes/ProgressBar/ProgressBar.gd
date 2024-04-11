extends TextureProgressBar

# Additional properties
var increment_amount = 10 # Default increment amount
var max_value_scaler = 1.12 # Max value scale coefficient
var progress_color = Color(0.0, 1.0, 0.0, 1.0) # Default color (Green)

func _ready():
	# Example usage of setters on ready
	value = 0
	max_value = 100 # Setting a default max value
	#set_progress_color(progress_color) # Applying the default color

func _process(delta):
	pass

# Increment function
func increment():
	value += increment_amount
	if value > max_value:
		value = value - max_value
		max_value = max_value * max_value_scaler

func decrement():
	value -= increment_amount
	if value < min_value:
		value = 0

# Current XP Value getters and setters
func get_current_value():
	return value

func set_current_value(new_value):
	value = new_value

# Increment Amount getters and setters
func get_increment_amount():
	return increment_amount

func set_increment_amount(new_increment_amount):
	increment_amount = new_increment_amount

# Progress Color getters and setters
func get_progress_color():
	return progress_color

func set_progress_color(new_color):
	progress_color = new_color
	modulate = new_color


func _on_timer_timeout():
	increment()
	pass # Replace with function body.
