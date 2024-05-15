class_name DamageNumber
extends Node2D
var rng = RandomNumberGenerator.new()

func display_number(value: int, heal = false) -> void:
	if value <= 0: return
	var number = Label.new()

	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	var color = "#F00"
	if heal:
		color = "#0F0"
	if value == 0:
		color = "FFF8"
	
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 10
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)

	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	var random_number = rng.randf_range(-10.0, 10.0)
	number.position.x += random_number
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_OUT).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_OUT).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
