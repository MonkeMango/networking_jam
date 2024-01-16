extends KinematicBody2D

var player
var is_awake = false
var is_flying = false
var target_position = Vector2()  # Set this to the position where the dragon should fly when awakened
var flying_speed = 50.0  # Adjust as needed

func _ready():
	player = get_node("/root/Level4/Player")  # Adjust the path based on your scene structure

func _process(delta):
	if is_awake and not is_flying:
		fly_to_target()

	if is_flying:
		move_and_collide(Vector2(flying_speed * delta, 0))

	check_player_proximity()

func check_player_proximity():
	if player and player.position.distance_to(position) < 50.0:
		awaken_dragon()

func awaken_dragon():
	is_awake = true
	# Add any additional logic for the dragon awakening, like visual effects or sounds

func fly_to_target():
	if position.distance_to(target_position) > 5.0:
		look_at(target_position)
	else:
		is_flying = false
		is_awake = false
		queue_free()  # Remove the dragon node when it reaches its destination
