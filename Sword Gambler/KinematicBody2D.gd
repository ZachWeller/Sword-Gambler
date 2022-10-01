extends KinematicBody2D

export (int) var speed = 100
var animation_direction = "Down"
var animation_mode = "Idle"
var animation
var velocity = Vector2(0,0)

func _physics_process(delta):
	normal_walk()
		
func _process(delta):
	AnimationLoop()

func normal_walk():
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	var motion = velocity.normalized() * speed
	move_and_slide(motion)
	
func AnimationLoop():
	match velocity:
		Vector2(-1,0):
			animation_direction = "Left"
		Vector2(1,0):
			animation_direction = "Right"
		Vector2(0,1):
			animation_direction = "Down"
		Vector2(0,-1):
			animation_direction = "Up"
		Vector2(-1,-1):
			animation_direction = "Left"
		Vector2(-1,1):
			animation_direction = "Left"
		Vector2(1,-1):
			animation_direction = "Right"
		Vector2(1,1):
			animation_direction = "Right"
		
	if velocity != Vector2(0,0):
		animation_mode = "Walk"
	else:
		animation_mode = "Idle"
	animation = animation_mode + "_" + animation_direction
	$AnimationPlayer.play(animation)
	print(animation)
	
	
#func sword_walk():
#	velocity = Vector2()
##	Walking Right Animtion
#	if Input.is_action_pressed("right"):
#		$AnimationPlayer.play("Sword_Right_Walk")
#		velocity.x += 1
#	elif Input.is_action_just_released("right"):
#		$AnimationPlayer.stop()
#		$AnimationPlayer.play("Right_Idle")
##	Walking Left Animation
#	if Input.is_action_pressed("left"):
#		velocity.x -= 1
#		$AnimationPlayer.play("Sword_Left_Walk ")
#	elif Input.is_action_just_released("left"):
#		$AnimationPlayer.stop()
#		$AnimationPlayer.play("Left_Idle")
##	Walking Down Animation
#	if Input.is_action_pressed("down"):
#		velocity.y += 1
#		$AnimationPlayer.play("Sword_Front_Walk")
#	elif Input.is_action_just_released("down"):
#		$AnimationPlayer.stop()
#		$AnimationPlayer.play("Front_Idle")
##	Walking Up Animation
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1
#		$AnimationPlayer.play("Sword_Back_Walk")	
#	elif Input.is_action_just_released("up"):
#		$AnimationPlayer.stop()
#		$AnimationPlayer.play("Back_Idle")
#
	velocity = velocity.normalized() * speed



