extends Control
@export var play_button: Button
func _ready():
	play_button.pressed.connect(_start)


func _start():
	Gamecontroller.load_level("LevelSelect")

func _quit():
	get_tree().quit()
