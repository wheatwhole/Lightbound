extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("fall")
	print("stop dashing")
	player.is_dashing = false
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

	if Input.get_axis("left", "right") != 0:
		player.change_state("RunningState")
	else:
		player.change_state("IdleState")
