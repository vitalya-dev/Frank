extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score = 0 setget score_set, score_get


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func score_set(val):
	score = clamp(val, 0, max_value)

func score_get():
	return score

func reset():
	score = 0	
	value = 0
	max_value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value != score:
		material.set_shader_param("shake", 1.0)
		value += sign(score - value)
		if !$Sound.playing:
			$Sound.play()
	else:
		material.set_shader_param("shake", 0.0)
