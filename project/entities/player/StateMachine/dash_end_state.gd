extends PlayerState

var dash_dir
var dash_end_timer = 0.15

func enter_state(player_node):
	super(player_node)
	dash_dir = player.previous_axis
 
	player.momentum_grace_timer = player.MOMENTUM_GRACE_DURATION

func handle_input(delta):
	dash_end_timer -= delta
	player.velocity.x -= player.velocity.x * delta * 5
	if abs(player.velocity.x) < (0.75 * player.DASH_SPEED):
		player.gravity_enabled = true
		player.is_dashing = false
		if player.axis.x != 0 and dash_end_timer <= 0:
			player.change_state("RunningState")
	
	if player.is_on_floor() and player.jump_buffer.time_left > 0:
		player.change_state("JumpingState")
