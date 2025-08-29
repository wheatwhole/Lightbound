extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func distort():
	self.visible = true
	animation_player.play("Distort")
	
func _process(_delta):
	await animation_player.animation_finished
	animation_player.stop()
	queue_free()
