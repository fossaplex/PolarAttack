extends CanvasModulate


signal day_tick(day)

const NIGHT_COLOR = Color("#1e212e")
const DAY_COLOR = Color("#e0e3ed")
const TIME_SCALE = 0.1

var time = 0
var last_day = 0

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	self.color = NIGHT_COLOR.lerp(DAY_COLOR, abs(sin(time)))
