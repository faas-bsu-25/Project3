extends Control

func _ready():
	$StartButton.pressed.connect(_start)
	$QuitButton.pressed.connect(_quit)

func _start():
	Gamecontroller.load_level("LevelSelect")

func _quit():
	get_tree().quit()
