extends PlayerState

var dash_end_timer = 0.2
var exit_velocity_x: float = 0.0
func enter_state(player_node):
	super(player_node) # FRANKY SUPER!
	dash_end_timer = 0.2  # reset every time
	player.gravity_enabled = true
	exit_velocity_x = player.axis.x * player.run_speed

func handle_input(delta):
	dash_end_timer -= delta

	# Only decay horizontal - gravity handles vertical on its own
	player.velocity.x = move_toward(player.velocity.x, exit_velocity_x, player.DASH_SPEED * delta * 4)

	if dash_end_timer <= 0:
		print("vel at end: ", player.velocity, " axis: ", player.axis.x)
		player.is_dashing = false  # now let _process take over friction
		if player.is_on_floor():
			player.change_state("IdleState")
		elif player.axis.x != 0:
			player.change_state("RunningState")
		else:
			player.change_state("FallingState")  # you have this - use it

	if Input.is_action_just_pressed("jump") and player.can_jump:
		player.change_state("JumpingState")

func exit_state():
	player.is_dashing = false
	player.gravity_enabled = true
