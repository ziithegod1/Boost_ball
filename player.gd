extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var basketball: Sprite2D = $basketball
@onready var smp: Node = $StateMachinePlayer

@onready var axis = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var cur_state = "running"

	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match cur_state:
		"running":
			running()
		"dribbling":
			dribbling()
	
	if Input.is_action_just_pressed("ui_down"):
		smp.set_param("has ball",false)
	elif Input.is_action_just_pressed("ui_up"):
		smp.set_param("has ball",true)
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
		#
		#if direction > 0:
			#player_sprite.flip_h = true
		#elif direction < 0:
			#player_sprite.flip_h = false
			#
		#
		#
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func running():
	
	basketball.visible = false
	player_sprite.play("dribble right")
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction > 0:
			player_sprite.flip_h = true
			$AnimationPlayer.play("bounce_flip")
		elif direction < 0:
			player_sprite.flip_h = false
			$AnimationPlayer.play("bounce")
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func dribbling():
	basketball.visible = true
	player_sprite.play("dribble right")
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction > 0:
			player_sprite.flip_h = true
			$AnimationPlayer.play("bounce_flip")
		elif direction < 0:
			player_sprite.flip_h = false
			$AnimationPlayer.play("bounce")
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _on_state_machine_player_updated(state: Variant, delta: Variant) -> void:
	cur_state = state
	pass # Replace with function body.
