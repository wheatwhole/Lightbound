extends CharacterBody2D


var jumping: float = 0
const JUMP_VELOCITY: float = -350.0 # negative because setting to positive just doesnt work. Probably because y in godot is negative
var ACCELERATION: float = 20
var FRICTION: float = 100
var gravity: float = 0
var base_run_speed: float = 340
var run_speed: float = 340

# physical nodes
@onready var player = $"."
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

# timers
@onready var coyote_timer = $CoyoteTimer
var coyote_frames = 600 
var coyote = false  
var last_floor = false  
var airtime: float = 0.0
var jumps_used: int = 0

# dashing
const DASH_SPEED: int = 700 # speed of the dash
const END_DASH_SPEED: int = 330 # speed the player moves after the dash; momentum

const DASH_DURATION: float = 0.025 # time in seconds for dash to last
const DASH_PAUSE_DURATION: float = 0.1
var dash_time = 0 # current time the player has been dashing for
var dash_pause_time = 0
var is_dashing: bool = false;
var just_dashed: bool = false;
var fulldashes = 100
var dashes = 1
var dash_end_velocity = Vector2.ZERO # velocity when the dash ended

# wavedashing
@onready var just_dashed_timer = $JustDashedTimer
var wavedash_speed = 500


var current_state
var axis 
var previous_axis = Vector2.RIGHT  # Default to right so dashing works on startup

@onready var jump_buffer_timer = $JumpBufferingTimer
func _ready():
	dashes = fulldashes
	coyote_timer.wait_time = coyote_frames / 60.0
	animation_player.play("land")
	change_state("IdleState")


	
func _process(delta: float) -> void:	
	get_input_axis()
	
	if current_state:
		current_state.handle_input(delta)
		
	gravity = Global.DEFAULT_GRAVITY

	if not is_on_floor():
		if abs(velocity.y) < 1:
			gravity *= 0.95
		else:
			gravity = Global.DEFAULT_GRAVITY
			
	if !is_dashing:
		velocity.y += gravity * delta
	elif is_dashing and axis.y == 1:
		velocity.y  += gravity * delta
		
	if !player == null and Input.is_action_just_released("jump"):
		if $RightOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$LeftOuter.is_colliding():
				player.global_position.x += 7
				
		elif $LeftOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$RightOuter.is_colliding():
				player.global_position.x -= 7

	airtime += delta
	if is_on_floor():
		airtime = 0.0
		jumps_used = 0
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
		
	if is_on_floor() and jump_buffer_timer.time_left > 0:
		change_state("JumpingState")
	
	if dash_end_velocity == Vector2.ZERO:
		dash_end_velocity = velocity
	move_and_slide()
	
func change_state(new_state_name: String):
	print("current state: ", current_state)
	if current_state:
		current_state.exit_state() # exit current state
	current_state = get_node(new_state_name) # chj
	if current_state: # ensure new state exists
		current_state.enter_state(self) # enter new state
		
func apply_movement() -> void:
	var dirx = Input.get_axis("left", "right")
	var diry = Input.get_axis("jump", "down")
	
	#if !is_dashing:
		#if dirx:
			#velocity.x = move_toward(velocity.x, dirx*SPEED, ACCELERATION)
		#else:
			#velocity.x = move_toward(velocity.x, 0 , FRICTION)

			
#func handle_landing(): 
##	was_in_air = not is_on_floor()
##	was_on_floor = is_on_floor()
##	just_landed = is_on_floor() and was_in_air
##	just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
#
##	if just_left_ledge:
	##	coyote_timer.start()
	#
##	if just_landed:
##		animation_player.play("land")
##		sprite_2d.animation = "land"
	#
##	if coyote_timer.time_left > 0:
##		print("coyote", coyote_timer.time_left)
#
	#last_floor = is_on_floor()
	#
	#if !is_on_floor() and last_floor and !jumping:
		#coyote = true
		#coyote_timer.start()
	#
	#if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		#change_state("JumpingState")

		
func get_input_axis() -> Vector2:
	axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("jump"))

	if axis != Vector2.ZERO:
		previous_axis = axis

	return axis

	
	
func _on_coyote_timer_timeout():
	coyote = false

func _on_just_dashed_timer_timeout() -> void:
	just_dashed = false
