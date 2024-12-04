extends Node

var levels:  Array

var levels_available: Array

var islands: Array
var islands_formatted: Array
var current_island: String

func _ready():
	levels = [1,2]
	
	islands = ["cloud_forest","shattered_savanna"]
	islands_formatted = ["Cloud Forest", "Shattered Savanna"]
	
	levels_available = [
		# Arrays work differenty in godot. Plugging "0" into an array returns the first value, "1" returns the second value and so on.
		# The numbers next to the "true or false" statements are referencing the number of the level
		true, #0
		false, #1
		false #2
	]
	
	print(levels_available.size())
	
func unlock_level(levelid: int):
	levels_available[levelid] = true
	return levels_available[levelid]
	
func level_status(levelid: int):
	var status = levels_available[levelid]
	return status

func clone(path, pos: Vector2):
	var new_scene = load(path)
	var newobject = new_scene.instantiate()
	newobject.position = Vector2(pos)
	return newobject

func get_island_formatted(islandid: int):
	return islands_formatted[islandid]
