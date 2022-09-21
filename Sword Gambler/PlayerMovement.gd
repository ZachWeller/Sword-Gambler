extends KinematicBody2D


export (int) var speed = 400
var velocity = Vector2()
var screen_size
onready var position2D = $Position2D

func _ready():
	screen_size = get_viewport().size

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		position2D.scale.x=-1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		position2D.scale.x=1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed

func _process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	if velocity.length() > 0:
		$Position2D/AnimatedSprite.play("walk")
	else:
		$Position2D/AnimatedSprite.stop()
	
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

