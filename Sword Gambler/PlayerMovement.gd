extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
onready var position2D = $Position2D
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		position2D.scale.x=-4
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		position2D.scale.x=4
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
