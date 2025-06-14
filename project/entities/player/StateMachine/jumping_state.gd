#IdleState
extends PlayerState

# reference to player node controlling the state
# called when entering the state

func enter_state(player_node):
	super(player_node)
	player.velocity.y = player.JUMP_VELOCITY	
	player.animation_player.play("jump")

	
func handle_input(_delta):
	
	
	if player.is_on_floor() or player.coyote_timer.time_left > 0.0:
		player.change_state("IdleState")

	if Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	

	
	if Input.get_axis("left", "right") != 0:
		player.change_state("RunningState")
