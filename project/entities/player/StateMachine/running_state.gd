extends PlayerState

func enter_state(player_node):
	super(player_node)

func handle_input(_delta):
	
	if player.axis.x != 0 and player.is_dashing == false:
		# positive acceleration on the player 
		player.velocity.x = move_toward(player.velocity.x, player.axis.x*player.run_speed, player.ACCELERATION)
		print("running state. dashes: ", player.dashes,  ", velocity: ", player.velocity.x )
	elif player.is_dashing == true:
		player.change_state("DashingState") # if the player uses the arrow keys and dashes at the exact same time, the game switches to the running state and never ends to the dash. this leads to gravity and friction being permanently disabled. This snippet runs if the player enters the running state prematurely 
	else:
		if player.dash_time == 0 and player.just_dashed == false:
			player.velocity.x = move_toward(player.velocity.x, 0 , player.FRICTION)

	if abs(player.velocity.x) < 1 and player.is_on_floor():
		player.change_state("IdleState")
	elif Input.is_action_just_pressed("jump") and player.jumps_used < 1 and player.airtime < 0.15:
		player.change_state("JumpingState")
	elif Input.is_action_just_pressed("dash") and player.dashes > 0:
		player.change_state("DashingState")
		
