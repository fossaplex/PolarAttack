extends Area2D

## Orbiting parameters
#@export var orbit_speed = 2.8  # How fast the object orbits around the player
#@export var base_orbit_radius = 35.0  # The base radius of the orbit
#@export var orbit_radius_variation = 5.0  # The amplitude of the orbit radius oscillation
#@export var wave_speed = .005  # Speed of the sine wave oscillation
#@export var orbit_angle = 0.0  # Current angle in the orbit
#var pitch_variation_range = 0.3 # Defines how much the pitch can vary
#var base_pitch = 1.0 # Normal pit
#@onready var attackable := $Attackable as Attackable
#
#func _process(delta):
	## Update the current angle based on the orbit speed
	#
	#orbit_angle += orbit_speed * delta
	## Ensure the angle wraps around correctly (optional, keeps the number manageable)
	#orbit_angle = fmod(orbit_angle,2 * PI)
	#var time = Time.get_ticks_msec()
	#var orbit_radius = base_orbit_radius + sin(time * wave_speed) * orbit_radius_variation
	#var max_orbit_radius = base_orbit_radius + orbit_radius_variation
	#$AudioStreamPlayer2D.volume_db = linear_to_db(1 - orbit_radius / max_orbit_radius)
	#$AudioStreamPlayer2D.pitch_scale = 1.0 + (max_orbit_radius - orbit_radius) / max_orbit_radius
#
	## Calculate the new position using trigonometry
	#var x = cos(orbit_angle) * orbit_radius
	#var y = sin(orbit_angle) * orbit_radius
	#
	## Update the position of the Area2D to orbit arou nd the player
	#position = Vector2(x, y)
#
#func _on_area_entered(area: Area2D):
	#if area.is_in_group("player_hitbox"):
#
		#var random_pitch = base_pitch + randf_range(-pitch_variation_range, pitch_variation_range) 
		#$AudioStreamPlayer.pitch_scale = random_pitch
		#$AudioStreamPlayer.play()
var radius: float = 30
var speed: float = 200
@export var angle_offset := 0.0
var angle_degrees = 0

func _process(delta: float):
	angle_degrees += speed * delta
	angle_degrees = fmod(angle_degrees, 360)  # Keep the angle in the range [0, 360]

	var angle := deg_to_rad(angle_degrees + angle_offset)
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	position = Vector2(x, y)
