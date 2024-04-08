extends Node2D

# Export an integer property that will represent the HeartState enum in the editor.
var heart_state = 0 : set = set_heart_state, get = get_heart_state
var is_ready = false

func _ready():
	is_ready = true
	# Any other ready-time initializations.
# Use a separate variable to hold the health state as a string, if necessary.
func showHeart(value):
	if is_ready:
		match value:
			2: # FUll
				$HeartFull.visible = true
				$HeartHalfFull.visible = false
				$HeartEmpty.visible = false
			1: # HALF FULL
				$HeartFull.visible = false
				$HeartHalfFull.visible = true
				$HeartEmpty.visible = false
			0: # EMPTY
				$HeartFull.visible = false
				$HeartHalfFull.visible = false
				$HeartEmpty.visible = true
	
# Getter function for heart_state, ensuring it returns the current health state.
func get_heart_state() -> String:
	return heart_state

# Setter function for heart_state, ensures it only accepts valid enum values.
func set_heart_state(value):
		heart_state = value
		showHeart(value)
