extends Control

@export var play_button: Button
@export var directions_button: Button
@export var quit_button: Button

func _ready():
	play_button.pressed.connect(_start)
	directions_button.pressed.connect(_open_directions)
	quit_button.pressed.connect(_quit)

func _start():
	Gamecontroller.load_level("LevelSelect")

func _open_directions():
	Gamecontroller.load_level("HowToDecode")

func _quit():
	get_tree().quit()
