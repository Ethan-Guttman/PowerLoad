extends CharacterBody2D

var gravity = 450.0
const WALK_SPEED = 200
const JUMP_SPEED = -350
var screen_size
#signal hit


func _ready():
	pass
	#screen_size = get_viewport_rect().size
	


func _physics_process(delta):
	velocity.y += delta * gravity

	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
		
	#position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "default"

	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	
