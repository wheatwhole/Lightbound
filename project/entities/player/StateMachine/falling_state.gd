extends PlayerState

func enter_state(player_node):
	super(player_node)

func handle_input(_delta):
	if Input.is_action_just_pressed("dash") and player.can_dash == true:
		player.change_state("DashingState")
	
	if player.is_on_floor():
		player.change_state("IdleState")
