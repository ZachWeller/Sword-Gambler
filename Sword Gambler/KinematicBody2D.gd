extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimationPlayer.play("Walk_Right")
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimationPlayer.play("Walk_Left")
	if Input.is_action_pressed("down"):
		velocity.y += 1
		$AnimationPlayer.play("Walk_Down")
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		$AnimationPlayer.play("Walk_Up")
	velocity = velocity.normalized() * speed
	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
