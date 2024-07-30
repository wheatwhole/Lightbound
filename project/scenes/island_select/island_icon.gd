@tool
extends Control
class_name IslandIcon

@export var island_index: int = 0
@export var next_island_up: IslandIcon
@export var next_island_down: IslandIcon
@export var next_island_left: IslandIcon
@export var next_island_right: IslandIcon
@export var level_select_packed: PackedScene = load("res://scenes/level_select/level_select.tscn")
@onready var level_select_scene: LevelSelect = level_select_packed.instantiate()
# Called when the node enters the scene tree for the first time.

func _ready():
		$Label.text = Global.get_island_formatted(island_index)
