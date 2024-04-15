extends CharacterHitbox

var is_damaging := false
var target : Character
var total_duration = 5.0
var elapsed_time = 0.0
@onready var attackable := $Attackable as Attackable

func _process(delta):
	if is_damaging and target:
	#if elapsed_time < total_duration:
		#var damage_this_frame = damage * delta
		attackable.deal_damange_delta(target, delta)
		#elapsed_time += delta

func _on_area_entered(area):
	if area is CharacterHitbox:
		is_damaging = true
		target = area.character

func _on_area_exited(area):
	is_damaging = false
	elapsed_time = 0.0
