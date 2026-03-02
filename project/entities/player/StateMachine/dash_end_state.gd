extends PlayerState

var dash_end_timer = 0.25
var initial_velocity: Vector2

func enter_state(player_node):
	super(player_node)
	player.gravity_enabled = false
	player.is_dashing = false
	initial_velocity = player.velocity

func handle_input(delta):
	dash_end_timer -= delta

	# Smoothly bleed off the full velocity together, not just x
	player.velocity = player.velocity.lerp(Vector2.ZERO, delta * 4.0)

	# Re-enable gravity gradually after a short float
	if dash_end_timer <= 0.1:
		player.gravity_enabled = true

	if dash_end_timer <= 0:
		if player.axis.x != 0:
			player.change_state("RunningState")
		elif player.is_on_floor():
			player.change_state("IdleState")
		else:
			player.change_state("JumpingState")

	if Input.is_action_just_pressed("jump") and player.can_jump:
		player.change_state("JumpingState")
