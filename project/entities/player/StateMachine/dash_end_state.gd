extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("fall")
	print("stop dashing")
	player.is_dashing = false
	
func handle_input(delta):
	var target_velocity = player.axis.normalized() * player.SPEED
	
	if player.axis.x == 0 and player.axis.y == 0:
		target_velocity = player.previous_axis.normalized() * player.SPEED
	# interpolate velocity towards input

	
	if Input.get_axis("left", "right") != 0:
		player.change_state("RunningState")
	else:
		player.change_state("IdleState")
