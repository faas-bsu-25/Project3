extends Control

@export var play_button: Button
@export var directions_button: Button
@export var quit_button: Button

func _ready():
	play_button.pressed.connect(_start) # When play button is selected then it goes to level select
	directions_button.pressed.connect(_open_directions)# button takes you to Directions scene
	quit_button.pressed.connect(_quit) # Quit button quits game when selected 

func _start():
	Gamecontroller.load_level("LevelSelect") # Takes you scene select 

func _open_directions():
	Gamecontroller.load_level("HowToDecode") # When selected it takes you to directions page 

func _quit():
	get_tree().quit() # quits game 
