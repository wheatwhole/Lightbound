@tool
extends Control

@export var island_index: int = 0
@export var level_select_packed: PackedScene = load("res://scenes/level_select/level_select.tscn")
@onready var level_select_scene: LevelSelect = level_select_packed.instantiate()
# Called when the node enters the scene tree for the first time.

func _ready():
		$Label.text = Global.get_island_formatted(island_index)
