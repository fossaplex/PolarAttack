extends Area2D

# Orbiting parameters
@export var orbit_speed = 2.8  # How fast the object orbits around the player
@export var base_orbit_radius = 35.0  # The base radius of the orbit
@export var orbit_radius_variation = 5.0  # The amplitude of the orbit radius oscillation
@export var wave_speed = .005  # Speed of the sine wave oscillation
@export var orbit_angle = 0.0  # Current angle in the orbit

var player  # Reference to the player node
var hud # Reference to HUD
@onready var hearts = get_node("/root/Level/Player/Camera2D/HeartsContainer")

func _ready():
	player = get_node("/root/Level/Player")  # Adjust the path to correctly point to your player node
	hud = get_node("/root/Level/Player/Camera2D/HUD")
	

func _process(delta):
	# Update the current angle based on the orbit speed
	
	orbit_angle += orbit_speed * delta
	# Ensure the angle wraps around correctly (optional, keeps the number manageable)
	orbit_angle = fmod(orbit_angle,2 * PI)
	var time = Time.get_ticks_msec()
	var orbit_radius = base_orbit_radius + sin(time * wave_speed) * orbit_radius_variation
	var max_orbit_radius = base_orbit_radius + orbit_radius_variation
	$AudioStreamPlayer2D.volume_db = linear_to_db(1 - orbit_radius / max_orbit_radius)
	$AudioStreamPlayer2D.pitch_scale = 1.0 + (max_orbit_radius - orbit_radius) / max_orbit_radius

	# Calculate the new position using trigonometry
	var x = cos(orbit_angle) * orbit_radius
	var y = sin(orbit_angle) * orbit_radius
	
	# Update the position of the Area2D to orbit arou nd the player
	position = Vector2(x, y)

func _on_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		body.queue_free() 
		hearts.subtract_health(1)
		$AudioStreamPlayer.play()
		#hud.update_score(5)
		var audio_player = get_parent().get_node("SoundKill")
		if audio_player:
			audio_player.play()


func _on_area_entered(area: Area2D):
	var parent = area.get_parent()
	var pitch_variation_range = 0.3 # Defines how much the pitch can vary
	var base_pitch = 1.0 # Normal pit
	if parent.is_in_group("enemies"):
		parent.queue_free() 
		hearts.subtract_health(1)
		var random_pitch = base_pitch + randf_range(-pitch_variation_range, pitch_variation_range) 
		$AudioStreamPlayer.pitch_scale = random_pitch
		$AudioStreamPlayer.play()
		var audio_player = get_parent().get_node("SoundKill")
		if audio_player:
			audio_player.play()

