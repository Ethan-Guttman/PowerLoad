extends StaticBody2D

var charging = false
var startReceived = false
var dangerBool = false
signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!charging && startReceived):
		$ChargingTimer.wait_time = 1;
		$ChargingTimer.start()
		$AnimatedSprite2D.animation = "charging"
		$AnimatedSprite2D.play()
		
		charging = true
	if (dangerBool):
		for body in $Area2D.get_overlapping_bodies():
			if(body.get_collision_layer() == 5):
				hit.emit()



func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_charging_timer_timeout():
	$ChargingTimer.stop()
	$ElectrifiedTimer.wait_time = 1
	$ElectrifiedTimer.start()
	$AnimatedSprite2D.animation = "danger"
	dangerBool = true

func _on_electrified_timer_timeout():
	$ElectrifiedTimer.stop()
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "default"
	startReceived = false
	charging = false
	dangerBool = false
