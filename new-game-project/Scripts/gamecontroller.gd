extends Node

var unlocked_levels = { "cyprus": true, "berlin": false, "warsaw": false }

func load_level(level_name: String):
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % level_name)

func unlock(level_name: String):
	unlocked_levels[level_name] = true
