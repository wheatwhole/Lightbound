extends CharacterBody2D

# jumping
const JUMP_VELOCITY: float = 350.0 # negative because setting to positive just doesnt work. Probably because y in godot is negative
# acceleration and friction
const ACCELERATION: float = 20
const FRICTION: float = 100
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



var gravity: float = 0
var base_run_speed: float = 200
var run_speed: float = base_run_speed
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

# dashing

# wavedashing
var wavedash_speed = 500


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

	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()
	
	gravity = Global.DEFAULT_GRAVITY

	if not is_on_floor():
		if abs(velocity.y) < 1:
			gravity *= 0.95
		else:
			gravity = Global.DEFAULT_GRAVITY

	if gravity_enabled == true:
		velocity.y += gravity * delta
		
	if !player == null and Input.is_action_just_released("jump"):
		if $RightOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$LeftOuter.is_colliding():
				player.global_position.x += 7
				
		elif $LeftOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$RightOuter.is_colliding():
				player.global_position.x -= 7

	# jump buffering and dash reset
	airtime += delta
	if is_on_floor():
		airtime = 0.0
		jumps_used = 0
		dashes = 0
		player.can_dash = true
	
	# commit movement
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
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("jump"))

	if axis.x != 0 or axis.y != 0:
		previous_axis = axis

	return axis

# Dashing

				

func _on_dash_timer_timeout() -> void:
	dashes += 1
	change_state("DashingState")

#func GetDashDirection() -> Vector2:
	#var _dir = Vector2.ZERO
	#get_input_axis()
	#_dir = previous_axis
	#return _dir
	
#func UpdateSquish():
	#pass
	#Sprite2D.scale.x = squishX
	#Sprite2D.scale.y = squishY
	#
	#if squishX != 0: squishX = move_toward(squishX, 1.0, squishStep)
	#if squishY != 0: squishY = move_toward(squishY, 1.0, squishStep)

#func SetSquish(_squishX: float = 1.0, _squishY: float = 1.0, _step: float = squishStep):
	#squishX = _squishX if (_squishX != 0) else 1.0
	#squishY = _squishY if (_squishY != 0) else 1.0
	#squishStep = _step if (_step != 0) else squishStep
