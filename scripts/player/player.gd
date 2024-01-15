extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var star_spawn : bool = false;

var star = preload("res://scenes/stars/stars.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		
		
	move_and_slide()

func _on_area_2d_body_entered(body):
	if !$"../Area2D/InteractButton".modulate == Color(1, 1, 1, 1):
		var tween = get_tree().create_tween()
		tween.tween_property($"../Area2D/InteractButton", "modulate", Color(1, 1, 1, 1), 0.3)
	
	#NOTE: If there is an intergrated function for this let me know for the love of jod
	star_spawn = true


func _on_area_2d_body_exited(body):
	if !$"../Area2D/InteractButton".modulate == Color(1, 1, 1, 0):
		var tween = get_tree().create_tween()
		tween.tween_property($"../Area2D/InteractButton", "modulate", Color(1, 1, 1, 0), 0.3)
	
	star_spawn = false

