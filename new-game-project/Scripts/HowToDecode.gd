extends Control

@export var BackButton: Button

func _ready():
	BackButton.pressed.connect(_go_back)

func _go_back():
	Gamecontroller.load_level("MainMenu")
