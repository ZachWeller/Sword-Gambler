extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500

var motion = Vector2.ZERO

onready var player = $AnimationPlayer
onready var playertree = $AnimationTree
onready var playerstate = playertree.get("parameters/playback")


func _physics_process(delta):
	var velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized()
	
	if velocity != Vector2.ZERO:
		playertree.set("parameters/Idle/blend_position", velocity)
		playertree.set("parameters/Walk/blend_position", velocity)
		playerstate.travel("Walk")
		motion = motion.move_toward(velocity * MAX_SPEED, ACCELERATION * delta)
	else:
		playerstate.travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)	
		
	motion = move_and_slide(motion)
		



	

	
