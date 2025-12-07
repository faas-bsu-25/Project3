extends Control

var broadcast_numbers = [6,3,6,4,6] #numbers from audio 
var private_key = [5,2,8,3,4] # key given to use to decode
var expected_message = ""

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar   # This should use your custom SuspicionBar.gd
@export var StateMachine: Node          # Must have StateMachine.gd attached


func _ready():
	# Generate expected decoded string
	expected_message = decode_message()

	# Show private key on screen
	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)

	# Start the state machine at LISTENING since audio has not yet finished playing
	StateMachine.set_state(StateMachine.State.LISTENING)

	# Load the broadcast audio stream
	BroadcastPlayer.stream = preload("res://Sounds/Poacher.mp3")

	# When audio finishes, switch state to DECODING
	BroadcastPlayer.finished.connect(func():
		# Audio done; now user can think/enter solution
		StateMachine.set_state(StateMachine.State.DECODING)
	)

	# Play broadcast
	BroadcastPlayer.play()


	InputField.text_changed.connect(func(_t):
		if StateMachine.state != StateMachine.State.COMPLETE:
			StateMachine.set_state(StateMachine.State.ENTERING)
	)

	# Connect submit button to input check
	SubmitButton.pressed.connect(_check_input)



func decode_message():
	# Decodes broadcast using private key
	var r = ""
	for i in range(broadcast_numbers.size()):
		var v = (broadcast_numbers[i] + private_key[i]) % 26
		r += char(v + 65)
	return r



# Checks input to see if valid; raises suspicion or moves to next level
func _check_input():
	var u = InputField.text.strip_edges().to_upper()

	# Only set COMPLETE on correct answer
	if u == expected_message:
		StateMachine.set_state(StateMachine.State.COMPLETE) # sets state to complete
		Gamecontroller.unlock("berlin")
		Gamecontroller.load_level("berlin")
	else:
		# Increase suspicion safely using your SuspicionBar's method
		if "add" in SuspicionBar:
			SuspicionBar.add(25)
		else:
			SuspicionBar.value += 25
