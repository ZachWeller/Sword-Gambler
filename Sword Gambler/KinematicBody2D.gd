extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 650
const FRICTION = 500

enum {
	MOVE,
	SWORDMOVE,
	ATTACK
}

var state = MOVE
var motion = Vector2.ZERO

onready var player = $AnimationPlayer
onready var playertree = $AnimationTree
onready var playerstate = playertree.get("parameters/playback")

func _ready():
	playertree.active = true
	$Player/Sword.hide()
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		SWORDMOVE:
			sword_state(delta)
	


func move_state(delta):
	var velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized()
		
	if velocity != Vector2.ZERO:
		playertree.set("parameters/Idle/blend_position", velocity)
		playertree.set("parameters/Walk/blend_position", velocity)
		playertree.set("parameters/Attack/blend_position", velocity)
		playerstate.travel("Walk")
		motion = motion.move_toward(velocity * MAX_SPEED, ACCELERATION * delta)
	else:
		playerstate.travel("Idle")
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)	
			
	motion = move_and_slide(motion)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	elif Input.is_action_just_pressed("Use"):
		state = SWORDMOVE
		
func attack_state(delta):
	playerstate.travel("Attack")
	
func attack_animation_finished():
	state = MOVE
	
func sword_state(delta):
	$Player/Sword.visible = !$Player/Sword.visible
	state = MOVE
	
