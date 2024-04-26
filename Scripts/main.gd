extends Node

var elementQueue = ["fire", "gravity", "electricity"]

var elecPlatforms
var fireTexture
var elecTexture
var gravTexture

@export var fireball_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Goal/AnimatedSprite2D.play()
	$ElementIntervalTimer.start()
	elecPlatforms = [$eleplatform, $eleplatform2, $eleplatform3, $eleplatform4, $eleplatform5, 
	$eleplatform6, $eleplatform7]
	for e in elecPlatforms:
		e.hit.connect(_gameOver)
	
	fireTexture = preload("res://Art/elements/flame.png")
	
	gravTexture = preload("res://Art/elements/gravity.png")
	
	elecTexture = preload("res://Art/elements/lightning.png")
	var elementsIcons = get_tree().get_nodes_in_group('elements')
	for i in range(3):
		#print("sneed")
		match elementQueue[i]:
			'fire':
				elementsIcons[i].texture = fireTexture
			'gravity':
				elementsIcons[i].texture = gravTexture
			'electricity':
				elementsIcons[i].texture = elecTexture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _gameOver():
	print("react fast chucklenuts")
	get_tree().reload_current_scene()


func _on_element_interval_timer_timeout():
	# advance the element queue
	var currElement = elementQueue[0]
	elementQueue.pop_front()
	var newElement = ['fire', 'gravity', 'electricity'][randi() % 3];
	while newElement == elementQueue[0] && newElement == elementQueue[1]:
		newElement = ['fire', 'gravity', 'electricity'][randi() % 3]
	elementQueue.append(newElement)
	match currElement:
		'fire':
			callFire()
		'gravity':
			callGravity()
		'electricity':
			callElectricity()
	var elementsIcons = get_tree().get_nodes_in_group('elements')
	for i in range(3):
		#print("sneed")
		match elementQueue[i]:
			'fire':
				elementsIcons[i].texture = fireTexture
			'gravity':
				elementsIcons[i].texture = gravTexture
			'electricity':
				elementsIcons[i].texture = elecTexture
	
	
func callFire():
	var newFireBall = fireball_scene.instantiate()
	newFireBall.position = $player.position
	#anewFireball.position.x += randf_range(-100, 100)
	add_child(newFireBall)
	newFireBall.hit.connect(_gameOver)
	pass

func callElectricity():
	for x in elecPlatforms:
		#print(x)
		x.startReceived = true
	pass
	
func callGravity():
	$GravityTimer.start()
	$player.gravity = 1000
	pass


func _on_gravity_timer_timeout():
	$GravityTimer.stop()
	$player.gravity = 450
