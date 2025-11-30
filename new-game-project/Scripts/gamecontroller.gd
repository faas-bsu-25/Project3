extends Node

var unlocked = { "cyprus": true, "berlin": false, "warsaw": false }

func load_level(name: String):
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % name)

func unlock(name: String):
	unlocked[name] = true
