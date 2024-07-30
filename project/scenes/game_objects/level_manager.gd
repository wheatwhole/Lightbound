extends Node
class_name LevelManager

@onready var points_panel = get_parent().get_node("UI/level_ui/points")
@onready var player = get_parent().get_node("Scene Objects/CharacterBody2D")
@onready var trophy: Trophy = get_parent().get_node("Scene Objects/trophy")


func _ready():
	pass

func add_point():
	points_panel.points += 1
	print(points_panel.points)
	points_panel.label.text = str("points - ", points_panel.points)

func _on_trophy_body_entered(body):
	if (body.name == "CharacterBody2D"):
		Global.unlock_level(trophy.next_level)
		print("trophy next level: ", trophy.next_level)
		print(Global.level_status(str(trophy.next_level))) # prints "available"
		get_tree().change_scene_to_file(trophy.next_scene)

