@tool
extends Control
class_name IslandIcon

@export var island_ID: int = 0 # In godot's arrays, 0 represents the first item and 1 represents the second and so on.
@export var next_island_up: IslandIcon
@export var next_island_down: IslandIcon
@export var next_island_left: IslandIcon
@export var next_island_right: IslandIcon
# To get variables from loaded scenes, a packed scene is used
@export var level_select_packed: PackedScene = load("res://scenes/level_select/cloud_forest/level_select.tscn")
@onready var level_select_scene: LevelSelect = level_select_packed.instantiate()
# Called when the node enters the scene tree for the first time.

func _ready():
	$Label.text = Global.get_island_formatted(island_ID)

func _process(_delta):
	if Engine.is_editor_hint():
			# $TextureRect.texture = load("res://Pixel Adventure 1/Free/Menu/Levels/" + str(worldwide_level_ID) +".png")
			$Label.text=Global.get_island_formatted(island_ID)
