extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".play("fade out")


func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	print("aw yeah")
	queue_free()
