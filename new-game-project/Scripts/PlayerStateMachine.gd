extends Node

signal state_changed(new_state)

enum State { LISTENING, DECODING, ENTERING, COMPLETE }
var state = State.LISTENING

func set_state(s):
	state = s
	emit_signal("state_changed", s)
