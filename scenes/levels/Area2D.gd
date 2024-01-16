extends Area2D

@export var player : CharacterBody2D
@export var star_limit : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.star_presses >= 1:
		player.star_presses = 0;
		$"../CutscenePlayer".play("griffin enters scene")
		Dialogic.start('first dialogue with griffin')
		queue_free()
