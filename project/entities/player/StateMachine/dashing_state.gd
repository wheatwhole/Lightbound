extends PlayerState

func enter_state(player_node):

	super(player_node)
	var dash_direction = player.previous_axis
	dash_direction == player.previous_axis
	print("start dash")
	player.is_dashing = true
	if player.dashes > 0:
		
		player.dashes -= 1	
		player.velocity = dash_direction * player.DASH_SPEED
		
		print("DASH_SPEED BEGIN: ", player.velocity)

func handle_input(delta):

	print("DASH SPEED CURRENT: ", player.velocity)
	
	player.change_state("DashEndState")	
