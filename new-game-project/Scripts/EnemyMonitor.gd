extends Node
signal sweep

func _process(delta):
	if randf() < 0.001: # low chance each frame
		emit_signal("sweep")
