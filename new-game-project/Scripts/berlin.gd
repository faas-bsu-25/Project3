extends Control

var broadcast_numbers = [0, 0, 9, 6]
var private_key = [14, 15, 21, 7]   # decodes to "OPEN"
var expected_message = ""

@export var PrivateKeyLabel: Label
@export var BroadcastPlayer: AudioStreamPlayer
@export var SubmitButton: Button
@export var InputField: LineEdit
@export var SuspicionBar: ProgressBar

func _ready():
	expected_message = decode_message()

	PrivateKeyLabel.text = "Private Key: %s" % str(private_key)

	BroadcastPlayer.stream = preload("res://Sounds/E14-4f-Control.ogg")
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
		Gamecontroller.unlock("warsaw")
		Gamecontroller.load_level("warsaw")
	else:
		SuspicionBar.add(25)
