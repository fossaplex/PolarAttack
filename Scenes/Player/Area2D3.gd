extends Area2D

# Orbiting parameters
var orbit_speed = 3.6  # How fast the object orbits around the player
var base_orbit_radius = 35.0  # The base radius of the orbit
var orbit_radius_variation = 5.0  # The amplitude of the orbit radius oscillation
var wave_speed = .005  # Speed of the sine wave oscillation
var orbit_angle = 135.0  # Current angle in the orbit

var player  # Reference to the player node

func _ready():
	player = get_node("/root/Level/Player")  # Adjust the path to correctly point to your player node

func _process(delta):
	# Update the current angle based on the orbit speed
	orbit_angle += orbit_speed * delta
	# Ensure the angle wraps around correctly (optional, keeps the number manageable)
	orbit_angle = fmod(orbit_angle,2 * PI)
	var time = Time.get_ticks_msec()
	var orbit_radius = base_orbit_radius + sin(time * wave_speed) * orbit_radius_variation
	# Calculate the new position using trigonometry
	var x = cos(orbit_angle) * orbit_radius
	var y = sin(orbit_angle) * orbit_radius
	
	# Update the position of the Area2D to orbit around the player
	position = Vector2(x, y)


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free() 
		var audio_player = get_parent().get_node("SoundKill")
		if audio_player:
			audio_player.play()
	pass # Replace with function body.
