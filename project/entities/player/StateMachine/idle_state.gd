#IdleState
extends PlayerState

# reference to player node controlling the state
# called when entering the state

func enter_state(player_node):
	super(player_node)
	
func handle_input(_delta):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.change_state("JumpingState")
	elif Input.get_axis("left", "right") != 0:
		player.change_state("RunningState")
	elif Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 100)
