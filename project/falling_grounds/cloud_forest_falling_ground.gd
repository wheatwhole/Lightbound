extends CharacterBody2D


var prevVelocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var gravity_multiplier: float = -0.00000980392*-350
@onready var sprite_2d = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var player = $"."
	
func _physics_process(_delta):	
	if not is_on_floor():
		# velocity.x=lerp(prevVelocity.x, velocity.x, 0)
		velocity.y += gravity*gravity_multiplier
		if abs(velocity.y) < 1:
			gravity *=0.95
		else:
			gravity = 4900

	move_and_slide()



