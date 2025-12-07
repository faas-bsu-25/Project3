extends Control

var broadcast_numbers = [3, 8, 4, 6, 3]        # numbers from audio
var private_key = [23, 24, 0, 7, 16]           # key used to decode
var expected_message = ""                      # decoded answer

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar           # custom SuspicionBar.gd script
@export var StateMachine: Node                  # must have StateMachine.gd attached


func _ready():
	# Get expected decoded string
	expected_message = decode_message()

	# Show private key on screen
	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)

	# Start the state machine in LISTENING mode
	StateMachine.set_state(StateMachine.State.LISTENING)

	# Load broadcast audio
	BroadcastPlayer.stream = preload("res://Sounds/E11.mp3")

	# When audio finishes, move to DECODING state
	BroadcastPlayer.finished.connect(func():
		StateMachine.set_state(StateMachine.State.DECODING)
	)

	# Play the broadcast
	BroadcastPlayer.play()

	# When user types, switch to ENTERING state (unless complete already)
	InputField.text_changed.connect(func(_t):
		if StateMachine.state != StateMachine.State.COMPLETE:
			StateMachine.set_state(StateMachine.State.ENTERING)
	)

	# Connect submit button to answer checking function
	SubmitButton.pressed.connect(_check_input)



func decode_message():
	# Decodes broadcast using private key
	var r = ""
	for i in range(broadcast_numbers.size()):
		var v = (broadcast_numbers[i] + private_key[i]) % 26
		r += char(v + 65)
	return r



# Checks user input. If correct → FinalScene, if not → increase suspicion
func _check_input():
	var u = InputField.text.strip_edges().to_upper()

	if u == expected_message:
		# Correct answer: set COMPLETE state
		StateMachine.set_state(StateMachine.State.COMPLETE)

		# Load final scene
		Gamecontroller.load_level("FinalScene")
	else:
		# Wrong answer: increase suspicion
		if "add" in SuspicionBar:
			SuspicionBar.add(25)
		else:
			SuspicionBar.value += 25
