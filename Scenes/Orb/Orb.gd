extends Area2D

# Orbiting parameters
@export var orbit_speed = 2.8  # How fast the object orbits around the player
@export var base_orbit_radius = 35.0  # The base radius of the orbit
@export var orbit_radius_variation = 5.0  # The amplitude of the orbit radius oscillation
@export var wave_speed = .005  # Speed of the sine wave oscillation
@export var orbit_angle = 0.0  # Current angle in the orbit

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

func _on_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		body.queue_free() 
		var audio_player = get_parent().get_node("SoundKill")
		if audio_player:
			audio_player.play()


func _on_area_entered(area: Area2D):
	var parent = area.get_parent()
	if parent.is_in_group("enemies"):
		parent.queue_free() 
		var audio_player = get_parent().get_node("SoundKill")
		if audio_player:
			audio_player.play()

