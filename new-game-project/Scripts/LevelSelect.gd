extends Control
@export var Cyprus_button: Button
@export var Berlin_button: Button
@export var Warsaw_button: Button
@export var BackButton: Button
func _ready():
	Cyprus_button.pressed.connect(func(): Gamecontroller.load_level("cyprus")) # loads First level when clicked
	Berlin_button.disabled = !Gamecontroller.unlocked["berlin"]# checks if unlocked and if so loads it 
	Warsaw_button.disabled = !Gamecontroller.unlocked["warsaw"]# checks if unlocked and if so loads it 
	BackButton.pressed.connect(func(): Gamecontroller.load_level("MainMenu"))# allows going back 
