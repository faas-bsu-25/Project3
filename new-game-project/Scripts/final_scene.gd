extends Control

@export var Menubutton: Button
@export var QuitButton: Button

func _ready():
	Menubutton.pressed.connect(func():
		Gamecontroller.load_level("main")
	)

	QuitButton.pressed.connect(func():
		get_tree().quit()
	)
