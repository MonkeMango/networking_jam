extends Area2D

var is_grown = false
var growth_speed = 20.0  # Adjust as needed
var player

func _ready():
	player = get_node("/root/Level2/Player")  # Adjust the path based on your scene structure

func _process(delta):
	if is_grown:
		return

	if player and player.position.distance_to(position) < 50.0:
		grow(delta)
		
func grow(delta):
	var new_scale = lerp_scale(Vector2(1, 1), Vector2(1, 5), growth_speed * delta)
	scale = new_scale

	if scale.y >= 5:
		is_grown = true
		# Trigger any additional logic when the vine is fully grown
		queue_free()  # Remove the platform if needed

# Function to interpolate between two scales
func lerp_scale(start_scale, end_scale, weight):
	return start_scale.linear_interpolate(end_scale, weight)
