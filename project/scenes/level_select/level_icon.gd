@tool
extends Node
class_name LevelIcon

@export var worldwide_level_index := "1"
@export var level_name: String
@export_file("*.tscn") var next_scene_path: String
@export var next_level_up: LevelIcon
@export var next_level_down: LevelIcon
@export var next_level_left: LevelIcon
@export var next_level_right: LevelIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	# $TextureRect.texture = load("res://Pixel Adventure 1/Free/Menu/Levels/" + str(level_name) +".png")
	$Label.text=level_name
func _process(_delta):
	if Engine.is_editor_hint():
			# $TextureRect.texture = load("res://Pixel Adventure 1/Free/Menu/Levels/" + str(level_name) +".png")
			$Label.text=level_name
