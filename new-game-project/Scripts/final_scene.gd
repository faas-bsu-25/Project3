extends Control

@export var Menubutton: Button
@export var QuitButton: Button

func _ready():
	MenuButton.pressed.connect(func(): Gamecontroller.load_level("MainMenu")) # makes button take to main 
	QuitButton.pressed.connect(func(): get_tree().quit()) # quits game
