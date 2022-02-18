extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var value = 0 setget value_set, value_get
var max_value = 0 setget max_value_set, max_value_get
var current  setget ,current_value_get
var _score = value

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(value)

func value_set(val):
	value = clamp(val, 0, INF)

func value_get():
	return value

func max_value_set(val):
	$ProgressBar.max_value = val

func max_value_get():
	return $ProgressBar.max_value

func reset():
	value = 0
	_score = 0
	$ProgressBar.max_value = 0
	$ProgressBar.value = 0

func current_value_get():
	return $ProgressBar.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _score != value:
		material.set_shader_param("shake", 1.0)
		material.set_shader_param("strength", 1.0)
		_score += sign(value - _score)
		if !$Sound.playing:
			$Sound.play()
		text = str(_score)
		$ProgressBar.value = _score
	else:
		material.set_shader_param("shake", 0.0)
		material.set_shader_param("strength", 0.0)
