extends Area2D

var is_broken = false
var player

func _ready():
	player = get_node("/root/Level3/Player")  # Adjust the path based on your scene structure

func _process(delta):
	if is_broken:
		return

	if player and player.position.distance_to(position) < 50.0:
		break_barrier()

func break_barrier():
	# Trigger any visual effects or sounds for breaking the barrier
	visible = false  # Make the barrier invisible
	collision_layer = 0  # Disable collision with the player
	is_broken = true
	queue_free()  # Remove the barrier node
