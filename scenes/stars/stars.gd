extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
const SPEED = 4.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	global_position = global_position.lerp(player.position, delta)
	
	print(position)


