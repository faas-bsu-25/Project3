extends ProgressBar

var suspicion = 0

func add(amount):
	suspicion += amount
	value = suspicion
	if suspicion >= max_value:
		Gamecontroller.load_level("GameOver")
