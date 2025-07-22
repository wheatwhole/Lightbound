#IdleState
extends PlayerState

# reference to player node controlling the state
# called when entering the state

func enter_state(player_node):
	super(player_node)
	player.jump_buffer_timer.stop()
	if player.velocity.y >= 0:
		player.velocity.y += player.JUMP_VELOCITY # conservation of momentum
	else:
		player.velocity.y = player.JUMP_VELOCITY
	
	# wave dashing
	if player.just_dashed and player.axis.x != 0 and player.velocity.y < 0 and player.just_dashed_timer.time_left > 0:
			player.velocity.x += player.axis.x * player.wavedash_speed
			player.run_speed = abs(player.velocity.x/2)
			player.just_dashed = false
func handle_input(_delta):
	if player.is_on_floor():
		player.change_state("IdleState")
	if Input.is_action_just_pressed("dash") and player.dashes > 0:
		player.change_state("DashingState")
	if player.axis.x != 0:
		player.change_state("RunningState")
