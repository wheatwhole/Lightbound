extends CollisionShape2D

@onready var falling_ground = get_parent()
@onready var ysize = falling_ground.ysize
@onready var xsize = falling_ground.xsize

func _ready():
	await get_parent().ready
	for i in int(ysize):
		print(i)
		var ydup = self.duplicate()
		self.get_parent().add_child.call_deferred(ydup)
		ydup.position += Vector2(0,16*int(i))
		print(ydup.position)
		for b in int(xsize):
			print(b)
			var xdup = ydup.duplicate()
			self.get_parent().add_child.call_deferred(xdup)
			xdup.position += Vector2(16*int(b),0)
			print(xdup.position)
	
	queue_free()
