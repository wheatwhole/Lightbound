extends Control

@onready var islands: Array = []
@onready var plricon: Node = $"Scene Objects/plricon"
@onready var current_island: IslandIcon = $"Scene Objects/Cloud Forest"

func _ready():
	plricon.global_position = current_island.global_position

func get_island_node_from_id(id):
	var island_node = get_node(str("Scene Objects/", Global.get_island_formatted(id)))
	return island_node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("left") and current_island.next_island_left:
		current_island = current_island.next_island_left
		plricon.global_position = current_island.global_position
	if event.is_action_pressed("right") and current_island.next_island_right: 
		current_island = current_island.next_island_right
		plricon.global_position = current_island.global_position
		
	if event.is_action_released("accept"):
		if current_island.level_select_scene:
			current_island.level_select_scene.parent_island_select = self
			get_tree().get_root().add_child(current_island.level_select_scene)
			get_tree().current_scene = current_island.level_select_scene
			get_tree().get_root().remove_child(self)

