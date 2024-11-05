extends CharacterBody2D

@export_enum("2x2", "2x3", "2x4", "2x5") var variant: String
var VariantsAndFrames = {
	"2x2":0,
	"2x3":1,
	"2x4":2,
	"2x5":3
}

var VariantsAndCollisionSizes = {
	"2x2":0,
	"2x3":1,
	"2x4":2,
	"2x5":3
}
var prevVelocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var gravity_multiplier: float = -0.00000980392*-350
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if Engine.is_editor_hint:
		animated_sprite.frame = VariantsAndFrames[variant]
	animated_sprite.frame = VariantsAndFrames[variant]
func _physics_process(_delta):	
	animated_sprite.frame = VariantsAndFrames[variant]
	if not is_on_floor():
		# velocity.x=lerp(prevVelocity.x, velocity.x, 0)
		velocity.y += gravity*gravity_multiplier
		if abs(velocity.y) < 1:
			gravity *=0.95
		else:
			gravity = 4900

	move_and_slide()



