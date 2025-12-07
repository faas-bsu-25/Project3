extends Control

var broadcast_numbers = [6,3,6,4,6] #numbers from audio 
var private_key = [5,2,8,3,4] # key given to use to decode
var expected_message = ""

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar

func _ready():
	expected_message = decode_message()

	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)# shows private Key on screen

	BroadcastPlayer.stream = preload("res://Sounds/Poacher.mp3")# loads sound
	BroadcastPlayer.play() # Plays it

	SubmitButton.pressed.connect(_check_input)


func decode_message():
	var r = ""
	for i in range(broadcast_numbers.size()):
		var v = (broadcast_numbers[i] + private_key[i]) % 26
		r += char(v + 65)
	return r

#decodes message
func _check_input():
	var u = InputField.text.strip_edges().to_upper()

	if u == expected_message:
		Gamecontroller.unlock("berlin")
		Gamecontroller.load_level("berlin")
	else:
		SuspicionBar.value += 25
# Checks input to see if valid and if not it makes the Suspicion bar go highrt
