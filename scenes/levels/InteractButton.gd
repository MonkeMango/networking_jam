extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
# NOTE: I do not know why I need to do this, I just have to do this or else it won't be invisible when the game starts.
	self.modulate = Color(1, 1, 1, 0)


