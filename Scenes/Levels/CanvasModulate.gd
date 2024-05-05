extends CanvasModulate

const NIGHT_COLOR = Color("#e0e3ed")
const DAY_COLOR = Color("#e0e3ed")
const TIME_SCALE = 0.01

var time := 0.0

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	self.color = NIGHT_COLOR.lerp(DAY_COLOR, abs(sin(time)))
