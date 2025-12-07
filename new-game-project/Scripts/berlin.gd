extends Control

var broadcast_numbers = [0, 0, 9, 6] # numbers from audio
var private_key = [14, 15, 21, 7]   # decodes to "OPEN"
var expected_message = ""

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar # custom SuspicionBar.gd should be attached
@export var StateMachine: Node         # MUST have StateMachine.gd attached


func _ready():
	# Decode expected answer ("OPEN")
	expected_message = decode_message()

	# Shows private key on screen
	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)

	# Set state to LISTENING before sound is played
	StateMachine.set_state(StateMachine.State.LISTENING)

	# Load audio for broadcast
	BroadcastPlayer.stream = preload("res://Sounds/E14.wav")

	# When audio finishes, switch to DECODING
	BroadcastPlayer.finished.connect(func():
		StateMachine.set_state(StateMachine.State.DECODING)
	)

	# Play broadcast sound
	BroadcastPlayer.play()


	InputField.text_changed.connect(func(_t):
		if StateMachine.state != StateMachine.State.COMPLETE:
			StateMachine.set_state(StateMachine.State.ENTERING)
	)

	# Connect the submit button
	SubmitButton.pressed.connect(_check_input)



# This function decodes a message
func decode_message():
	var r = ""
	for i in range(broadcast_numbers.size()):
		var v = (broadcast_numbers[i] + private_key[i]) % 26
		r += char(v + 65)
	return r



# Checks input to see if valid and increases suspicion on wrong answer
func _check_input():
	var u = InputField.text.strip_edges().to_upper()

	if u == expected_message:
		# Correct answer: set COMPLETE state
		StateMachine.set_state(StateMachine.State.COMPLETE)

		# Unlock and load Warsaw
		Gamecontroller.unlock("warsaw")
		Gamecontroller.load_level("warsaw")
	else:
		# Wrong answer, increase suspicion
		if "add" in SuspicionBar:
			SuspicionBar.add(25)
		else:
			SuspicionBar.value += 25
