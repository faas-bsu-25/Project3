extends Control

@export var RetryButton: Button
@export var QuitButton: Button

func _ready():
	RetryButton.pressed.connect(func(): Gamecontroller.load_level("LevelSelect"))
	QuitButton.pressed.connect(func(): get_tree().quit())
