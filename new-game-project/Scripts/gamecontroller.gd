extends Node

var unlocked = { "cyprus": true, "berlin": false, "warsaw": false }# unlocks and locks levels

func load_level(level_name: String):
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % level_name)# loads level

func unlock(Level_Key: String):
	unlocked[Level_Key] = true #unlocks level
