extends Node2D

var player_position : Vector2 
const SPEED = 4.0
const JUMP_VELOCITY = -400.0
const FRICTION = 20.0
var time : float = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	global_position = global_position.lerp(player_position, delta)
	
	print(position)


