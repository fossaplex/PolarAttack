extends SingleFiniteStateMachine

var elasped_time := 0.0
var transitioned := false

func process_frame(delta: float) -> void:
	super(delta)
	elasped_time += delta
	if not transitioned and elasped_time > 1:
		transitioned = true
