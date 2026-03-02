extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("run")

func handle_input(delta):
	# Switch to idle when nearly stopped
	if abs(player.velocity.x) < 1 and player.is_on_floor():
		player.change_state("IdleState")
	if Input.is_action_just_pressed("jump") and player.jumps_used < 1 and player.airtime < 0.15:
		player.change_state("JumpingState")
	if Input.is_action_just_pressed("dash") and player.can_dash:
		player.change_state("DashingState")
