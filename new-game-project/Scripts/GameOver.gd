extends Control

@export var RetryButton: Button
@export var QuitButton: Button

func _ready():
	RetryButton.pressed.connect(func(): Gamecontroller.load_level("LevelSelect"))#allows you to retry 
	QuitButton.pressed.connect(func(): get_tree().quit()) # allows Quiting
