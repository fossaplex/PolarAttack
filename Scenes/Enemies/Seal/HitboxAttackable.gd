extends Attackable

var is_damaging := false
var character : Character
var total_duration = 5.0
var elapsed_time = 0.0

func _process(delta):
	if is_damaging and character:
		if elapsed_time < total_duration:
			var damage_this_frame = damage * delta
			deal_damange_delta(character, delta)
			elapsed_time += delta

