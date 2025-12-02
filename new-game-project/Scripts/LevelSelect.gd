extends Control
@export var Cyprus_button: Button
@export var Berlin_button: Button
@export var Warsaw_button: Button
func _ready():
	Cyprus_button.pressed.connect(func(): Gamecontroller.load_level("cyprus"))
	Berlin_button.disabled = !Gamecontroller.unlocked["berlin"]
	Warsaw_button.disabled = !Gamecontroller.unlocked["warsaw"]
