class_name ModifierData

var min_level: int
var max_level: int
var modifier_creator: Callable
var weight_override: Callable

func _init(_min_level: int, _max_level: int, _modifier_creator: Callable, _weight_override: Callable = func() -> float: return -1.0) -> void:
	modifier_creator = _modifier_creator
	min_level = _min_level
	max_level = _max_level
	weight_override = _weight_override

func get_weight(level: int, decay_factor:float = 0.95, optimal_range: float = 10) -> float:
	var temp_weight := weight_override.call() as float
	if temp_weight >= 0:
		return temp_weight
	var range_width := max_level - min_level
	var base_weight_inside_range = 0.9 * (optimal_range / range_width);
	if level >= min_level and level <= max_level:
		return min(max(base_weight_inside_range, 0.1), 0.9);
	else:
		var distance := min_level - level if level < min_level else level - max_level
		var weight := 0.99 * pow(decay_factor, distance)
		return max(weight, 0.011)
