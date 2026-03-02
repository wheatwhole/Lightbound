extends CharacterBody2D

# jumping
const JUMP_VELOCITY: float = 350.0
var can_jump: bool = true
 # negative because setting to positive just doesnt work. Probably because y in godot is negative
# acceleration and friction
const BASE_RUN_SPEED: float = 200
var run_speed: float = BASE_RUN_SPEED
const FRICTION: float = 100
const ACCELERATION: float = 20
var momentum_grace_timer = 0.0
const MOMENTUM_GRACE_DURATION = 0.2

# dashing
const MAX_DASHES = 1
const DASH_SPEED = 350 
const DASH_DURATION = 0.1
var dashes = 0
var can_dash: bool = true
var dash_time = 0.25
var is_dashing = false
var dash_direction = Vector2.RIGHT
var wavedash_speed = 500



var gravity: float = 0
var gravity_enabled = true
var friction_enabled = true


# Nodes
@onready var player = $"."
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var jump_buffer = $Timers/JumpBuffer
var dash_distortion
# coyote jumping
var last_floor = false  
var airtime: float = 0.0
var jumps_used: int = 0

var current_state # state machine
var axis 
var previous_axis = Vector2.RIGHT  # Default to righ t so dashing works on startup

func _ready():
	animation_player.play("land")
	change_state("IdleState")


	
func _process(delta: float) -> void:	
	get_input_axis()

	if current_state:
		current_state.handle_input(delta)
	
	momentum_grace_timer = max(momentum_grace_timer - delta, 0)


	# gravity
	gravity = Global.DEFAULT_GRAVITY

	if not is_on_floor():
		if abs(velocity.y) < 1: 
			gravity *= 0.95
		else:
			gravity = Global.DEFAULT_GRAVITY

	if gravity_enabled == true:
		velocity.y += gravity * delta
	# friction
	if not player.is_dashing:
		var velocity_weight: float = delta * (ACCELERATION if axis.x else FRICTION)
		velocity.x = lerp(velocity.x, axis.x * run_speed, velocity_weight)
			
	# shift the player if they hit a ledge
	if !player == null and Input.is_action_just_released("jump"):
		if $RightOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$LeftOuter.is_colliding():
				player.global_position.x += 7
				
		elif $LeftOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$RightOuter.is_colliding():
				player.global_position.x -= 7
	
	# jumping
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()
	
	airtime += delta
	if is_on_floor():
		airtime = 0.0
		jumps_used = 0
		dashes = 0
		player.can_dash = true
	
	if jumps_used < 1 and airtime < 0.15:
		player.can_jump = true
	elif jumps_used < 1 and airtime < 0.15 and jump_buffer.time_left > 0:
		player.can_jump = false
	else:
		player.can_jump = false
	

	
	
	move_and_slide()
	

func change_state(new_state_name: String):
	print("changing state to ", new_state_name)
	if current_state:
		current_state.exit_state() # exit current state
	current_state = get_node(new_state_name) # chj
	if current_state: # ensure new state exists
		current_state.enter_state(self) # enter new state

		
func get_input_axis() -> Vector2:
	axis = Vector2.ZERO
	axis.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	axis.y = Input.get_action_strength("down") - Input.get_action_strength("jump")

	if axis.x != 0 or axis.y != 0:
		previous_axis = axis

	return axis
