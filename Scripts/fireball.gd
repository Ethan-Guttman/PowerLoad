extends Area2D

var isDanger = false
var _player = null
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	$DangerTimer.start()
	$DieTimer.start()
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "default"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (isDanger):
		$AnimatedSprite2D.animation = "burst"
		#print(get_overlapping_bodies())
		for body in get_overlapping_bodies():
			if(body.get_collision_layer() == 5):
				hit.emit()
				#print("here")
	



func _on_die_timer_timeout():
	queue_free()


func _on_danger_timer_timeout():
	isDanger = true
	pass # Replace with function body.


