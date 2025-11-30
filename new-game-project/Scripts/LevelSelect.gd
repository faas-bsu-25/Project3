extends Control

func _ready():
	$CyprusButton.pressed.connect(func(): Gamecontroller.load_level("cyprus"))
	$BerlinButton.disabled = !Gamecontroller.unlocked["berlin"]
	$WarsawButton.disabled = !Gamecontroller.unlocked["warsaw"]
