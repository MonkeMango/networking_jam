extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start('ending dialogue')
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.signal_event.connect(_on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeline_started():
	pass

func _on_timeline_ended():
	get_tree().change_scene_to_file("res://scenes/levels/credits.tscn")

func _on_dialogic_signal(argument : String):
	if argument == "dap me up":
		$AnimationPlayer.play("transition pictures")


