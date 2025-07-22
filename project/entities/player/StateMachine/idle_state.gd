#IdleState
extends PlayerState

# reference to player node controlling the state
# called when entering the state

func enter_state(player_node):
	super(player_node)
	player.dashes = player.fulldashes
	
func handle_input(_delta):			
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.change_state("JumpingState")
	elif player.axis.x != 0:
		player.change_state("RunningState")
	elif Input.is_action_just_pressed("dash") and player.dashes > 0:
		player.change_state("DashingState")
