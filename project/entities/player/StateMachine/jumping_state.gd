#IdleState
extends PlayerState

# reference to player node controlling the state
# called when entering the state
var wavedashed: bool = false

func enter_state(player_node):
	super(player_node)
	player.jump_buffer.stop()
	player.gravity_enabled = true
	if player.velocity.y >= 0:
		player.velocity.y = -player.JUMP_VELOCITY # conservation of momentum
	else:
		player.velocity.y = -player.JUMP_VELOCITY
	
	if abs(player.velocity.x) > 350 and abs(player.velocity.y) > 350:
		player.velocity.x += player.dash_direction * 1000
			
func handle_input(delta):
	
	if player.is_on_floor():
		player.change_state("IdleState")
	if player.axis.x != 0:
		player.change_state("RunningState")
		
	if Input.is_action_just_pressed("dash"):
		player.change_state("DashingState")
