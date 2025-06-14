extends PlayerState

func enter_state(player_node):
	super(player_node)
	player.animation_player.play("fall")

func handle_input(_delta):
	if Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
	
	if player.is_on_floor():
		player.change_state("IdleState")
