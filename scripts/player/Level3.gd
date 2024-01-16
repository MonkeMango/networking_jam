extends Node2D

var timer = 600  # 10 minutes in seconds
var player
var starfall
var barriers = []

func _ready():
	player = preload("res://scenes/player/player.tscn").instance()
	starfall = preload("res://scenes/stars/stars.tscn").instance()
	
	add_child(player)
	add_child(starfall)

	starfall.connect("star_collected", self, "_on_star_collected")

	for i in range(5):  # Adjust as needed
		var barrier = preload("res://BreakableBarrier.tscn").instance()
		barrier.position.x = randi() % 500  # Adjust as needed
		barrier.position.y = randi() % 300  # Adjust as needed
		barriers.append(barrier)
		add_child(barrier)

	set_process(true)

func _process(delta):
	timer -= delta

	if timer <= 0:
		_on_game_over()

func _on_star_collected(): 
	player.can_move = false  # Disable player movement
	await get_tree().create_timer(3.0).timeout  # Wait for 3 seconds
	_on_next_level()

func _on_game_over():
	# Implement game over logic here
	print("Game Over! You ran out of time.")
	# You may want to show a game over screen, reset the level, or return to the main menu.

func _on_next_level():
	# Transition to the next level
	pass
