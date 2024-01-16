extends Area2D

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.star_presses >= 1:
		player.star_presses = 0;
		Dialogic.start('second_star')
		queue_free()
