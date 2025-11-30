extends Button

func _ready():
	disabled = !Gamecontroller.unlocked_levels["berlin"]

func _on_east_berlin_pressed() -> void:
	Gamecontroller.load_level("berlin")
