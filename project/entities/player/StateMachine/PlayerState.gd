# PlayerState.gd
# base class for all states
extends Node
class_name PlayerState
# reference to player node controlling the state
var player
# called when entering the state
func enter_state(player_node):
	player = player_node
	
# exiting the state
func exit_state():
	pass

func handle_input(_delta):
	pass # no input handling in this base state
	# each state will have unique input handling
