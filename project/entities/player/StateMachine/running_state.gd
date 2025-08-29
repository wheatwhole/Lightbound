extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("run")

func handle_input(delta):
	var input_dir = player.axis.x
	var max_run_speed = player.run_speed

	# If recently dashed, limit max speed briefly

	var target_speed = input_dir * max_run_speed

	if input_dir != 0:
		player.velocity.x = move_toward(player.velocity.x, target_speed, player.ACCELERATION)
	else:
		if player.friction_enabled:
			player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION)


	# Switch to idle when nearly stopped
	if abs(player.velocity.x) < 1 and player.is_on_floor():
		player.change_state("IdleState")
	elif Input.is_action_just_pressed("jump") and player.jumps_used < 1 and player.airtime < 0.15:
		player.change_state("JumpingState")
	elif Input.is_action_just_pressed("dash") and player.can_dash:
		player.change_state("DashingState")
