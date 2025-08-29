extends PlayerState

var direction
var dash_distortion = preload("res://entities/player/dash_distortion/dash_distortion.tscn")
func enter_state(player_node):
	super(player_node)

		
	if player.can_dash:
		OS.delay_msec(30)
		var _distortion = dash_distortion.instantiate()
		_distortion.global_position = player.global_position
		get_tree().get_root().get_node("Level").add_child(_distortion)
		_distortion.distort()
		
		player.dash_direction = player.previous_axis
		player.dash_time = player.DASH_DURATION
		player.dashes += 1
		if player.dashes == player.MAX_DASHES:
			player.can_dash = false
			
		player.is_dashing = true
		player.dash_time = player.DASH_DURATION
		player.gravity_enabled = false
		
		player.velocity = player.dash_direction.normalized() * player.DASH_SPEED

func handle_input(delta):
	if player.is_dashing:
		player.dash_time -= delta


	# Keep dash velocity during dash time
	if player.dash_time <= 0:
		player.change_state("DashEndState")
	
