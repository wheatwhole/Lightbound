extends Control

@onready var islands: Array = []
@onready var plricon: Node = $"Scene Objects/plricon"
var current_island: int = 0

func _ready():
	plricon.global_position = get_island_node_from_id(current_island).global_position

func get_island_node_from_id(id):
	var island_node = get_node(str("Scene Objects/", Global.get_island_formatted(id)))
	return island_node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	print(get_island_node_from_id(current_island))
	if event.is_action_pressed("left") and current_island > 0:
		current_island -= 1
		plricon.global_position = get_island_node_from_id(current_island).global_position
		print(get_island_node_from_id(current_island))
	if event.is_action_pressed("right") and current_island < Global.islands_formatted.size() - 1: 
		current_island += 1
		plricon.global_position = get_island_node_from_id(current_island).global_position
		print(get_island_node_from_id(current_island))
		
	if event.is_action_released("accept"):
		if get_island_node_from_id(current_island).level_select_scene:
			Global.set_current_island(current_island)
			get_island_node_from_id(current_island).level_select_scene.parent_island_select = self
			get_tree().get_root().add_child(get_island_node_from_id(current_island).level_select_scene)
			get_tree().current_scene = get_island_node_from_id(current_island).level_select_scene
			get_tree().get_root().remove_child(self)

