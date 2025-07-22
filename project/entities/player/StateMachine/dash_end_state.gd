extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("fall")
	print("stop dashing")
	

func handle_input(delta):
	#var target_velocity = player.axis.normalized() * player.SPEED
	#
	#if player.axis.x == 0 and player.axis.y == 0:
		#target_velocity = player.previous_axis.normalized() * player.SPEED
	# interpolate velocity towards input
	#var target = 0.0
	#var smooth_velocity_x = lerp(player.velocity.x, target, 10 * delta)
	#player.velocity.x = smooth_velocity_x
	#player.velocity.x = 0
	#player.velocity.x = move_toward(player.velocity.x, 0 , player.FRICTION)

	player.dashes = player.fulldashes
	
	player.dash_end_velocity = player.velocity
	player.velocity -= player.velocity * 1 * delta 
	
	print("height dash: ", player.global_position.y)
	if player.previous_axis.y == -1:
		player.velocity.y -= player.velocity.y * delta
	
	if player.is_dashing:    
		if player.dash_time <= player.DASH_DURATION:
			player.dash_time += delta
		else:
			player.dash_time = 0

	if player.dash_time == 0 or player.is_on_floor():
		player.just_dashed = true
		player.is_dashing = false
		player.just_dashed_timer.start()
		
	if player.is_dashing == false:
		print('switching from dash to running')
		player.change_state("RunningState")
		
	#if abs(player.velocity.x) < 300:
		#if player.axis.x != 0:
			#pass
		#else:
			#player.change_state("IdleState")
