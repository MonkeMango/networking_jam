extends CharacterBody2D

enum {
	IDLE,
	MOVE,
	AIR,
	CUTSCENE
}

const ACCEL = 50.0
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const FRICTION = 20.0

@onready var anim_player = $AnimationPlayer
@onready var jump_buffer = $Timers/JumpBuffer

@export var camera : Camera2D 
var star_spawn : bool = false;

var stars : int = 0;

var star_presses : int = 0;
var state : int = IDLE
var star = preload("res://scenes/stars/stars.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var star_hud : RichTextLabel

func _ready():
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _input(event):
	
	if event.is_action_pressed("jump"):
		jump_buffer.start();
		
	if event.is_action_pressed("interact") and star_spawn:
		$Sounds/Star.play()
		star_presses += 1
		stars += 1
	
func get_input_direction() -> float:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction < 0:
		$Sprite2D.flip_h = true
	elif direction > 0:
		$Sprite2D.flip_h = false
	return direction

func _physics_process(delta):
	
	# Add the gravity.
	
	if not is_on_floor():
		state = AIR
		velocity.y += gravity * delta



	if state != CUTSCENE:
		# checks from input function if player is moving or not
		camera.global_position = self.position
		if not is_zero_approx(get_input_direction()):
			move(delta)
		else:
			velocity.x = lerp(velocity.x, 0.0, FRICTION * delta)
			if is_on_floor():
				state = IDLE
			
		if velocity.y < 0:
			anim_player.play("jump")
			
		# Handle jump.
		if !jump_buffer.is_stopped() and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION * delta)
	move_and_slide()
	
	if star_presses > 5:
		star_presses = 0;
	
	print(state)
	
	match state:
		AIR:
			anim_player.play("jump")
		IDLE:
			anim_player.play("idle")
		MOVE:
			anim_player.play("walk")
			if $Timers/FootLettuce.time_left <= 0:
				$Sounds/Walk.pitch_scale = randf_range(0.8, 1.1)
				$Sounds/Walk.play()
				$Timers/FootLettuce.start(0.8)

func _process(delta):
	star_hud.text = ": %s" % [stars]
	if stars > 3:
		$"../StarBlock".queue_free()

#handles movement
func move(delta : float) -> void:
	velocity.x = lerp(velocity.x, get_input_direction() * SPEED, ACCEL * delta);
	if is_on_floor():
		state = MOVE

#handles interact button
func _on_area_2d_body_entered(body):
	#FIXME: fuck it we ball yanderedev style
	if $"../Area2D":
		if !$"../Area2D/InteractButton".modulate == Color(1, 1, 1, 1):
			var tween = get_tree().create_tween()
			tween.tween_property($"../Area2D/InteractButton", "modulate", Color(1, 1, 1, 1), 0.3)
		
	#NOTE: If there is an intergrated function for this let me know for the love of jod
	star_spawn = true

func _on_area_2d_body_exited(body):
	if $"../Area2D":
		if !$"../Area2D/InteractButton".modulate == Color(1, 1, 1, 0):
			var tween = get_tree().create_tween()
			tween.tween_property($"../Area2D/InteractButton", "modulate", Color(1, 1, 1, 0), 0.3)
	
	star_spawn = false


func _on_timeline_started():
	state = CUTSCENE

func _on_timeline_ended():
	state = MOVE

func _on_dialogic_signal(argument:String):
	
	match argument:
		"GYATT":
			$"../CutscenePlayer".play("griffin exits scene")
		"come back down mr griffin":
			$"../CutscenePlayer".play("griffin enters scene")
		"bye bye mr wings worth":
			$"../CutscenePlayer".play("griffin exits scene")
			$"../TutorialBlock".queue_free()



func _on_area_2d_4_body_entered(body):
	$Camera2D/CanvasLayer/AnimationPlayer.play("fade in")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade in":
		get_tree().change_scene_to_file("res://scenes/levels/ENDING.tscn")
