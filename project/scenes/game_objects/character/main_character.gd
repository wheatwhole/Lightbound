extends CharacterBody2D


var jumping = 0
const SPEED = 500.0
const JUMP_VELOCITY = -1050.0
const ACCELERATION = 20
const FRICTION = 5000
var prevVelocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var gravity_multiplier: float = -0.00002941176*JUMP_VELOCITY
@onready var sprite_2d = $Sprite2D
@onready var coyote_timer = $CoyoteTimer
@onready var animation_player = $AnimationPlayer
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var player = $"."

var jump_buffer_timer: float = 0

func _ready():
	animation_player.play("land")

func handle_animation ():
	if (velocity.x > 1 || velocity.x < -1) and is_on_floor():
		sprite_2d.animation = "running"
	elif is_on_floor():
		sprite_2d.animation = "default"
			
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		animation_player.play("jump")
		
	if velocity.y > 100:
		animation_player.play("fall")
	
func _physics_process(delta):	
	if not is_on_floor():
		# velocity.x=lerp(prevVelocity.x, velocity.x, 0)
		velocity.y += gravity*gravity_multiplier
		if abs(velocity.y) < 50:
			gravity *=0.95
		else:
			gravity = 1700
		
	if  Input.is_action_just_pressed("jump") and is_on_floor () or Input.is_action_just_pressed("jump") and coyote_timer.time_left> 0.0:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.45
		
	if !player == null and Input.is_action_just_released("jump"):
		if $RightOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$LeftOuter.is_colliding():
				player.global_position.x += 12
				
		elif $LeftOuter.is_colliding() and !$RightInner.is_colliding() \
			and !$LeftInner.is_colliding() and !$RightOuter.is_colliding():
				player.global_position.x -= 12

	var direction = Input.get_axis("left", "right")
	if direction:
		# velocity.x = direction * ACCELERATION
		velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0 , FRICTION)

	var was_in_air: bool = not is_on_floor()
	var was_on_floor: bool = is_on_floor()
	move_and_slide()
	var just_landed: bool = is_on_floor() and was_in_air
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0

	if just_left_ledge:
		coyote_timer.start()
	
	if just_landed:
		animation_player.play("land")
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	handle_animation()
