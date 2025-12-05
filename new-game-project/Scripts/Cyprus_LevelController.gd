extends Control

var broadcast_numbers = [6,3,6,4,6]
var private_key = [5,2,8,3,4]
var expected_message = ""

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar

func _ready():
	expected_message = decode_message()

	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)

	BroadcastPlayer.stream = preload("res://Sounds/Poacher.mp3")
	BroadcastPlayer.play()

	SubmitButton.pressed.connect(_check_input)


func decode_message():
	var r = ""
	for i in range(broadcast_numbers.size()):
		var v = (broadcast_numbers[i] + private_key[i]) % 26
		r += char(v + 65)
	return r


func _check_input():
	var u = InputField.text.strip_edges().to_upper()

	if u == expected_message:
		Gamecontroller.unlock("berlin")
		Gamecontroller.load_level("berlin")
	else:
		SuspicionBar.value += 25
