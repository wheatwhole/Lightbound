extends Node

var levels:  Array

var levels_available: Dictionary

var islands: Array

var islands_formatted: Array
var current_island: String

func _ready():
	levels = [1,2]

	levels_available = {
		"1" : true, 
		"2" : false,
		"3" : false
	}
	
	islands = ["cloud_forest","shattered_savanna"]
	islands_formatted = ["Cloud Forest", "Shattered Savanna"]
func unlock_level(lvlname):
	Global.levels_available[lvlname] = true

func clone(path, pos):
	var new_scene = load(path)
	var clone = new_scene.instantiate()
	clone.position = Vector2(pos)
	return clone

func set_current_island(islandid: int):
	current_island = islands[islandid]

func get_island_formatted(islandid: int):
	return islands_formatted[islandid]
