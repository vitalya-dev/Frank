extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var levels = [
	'res://Scenes/Level_-1/Level_-1.tscn', 'res://Scenes/Level_0/Level_0.tscn', 'res://Scenes/Level_1/Level_1.tscn', 
	'res://Scenes/Level_2/Level_2.tscn', 'res://Scenes/Level_3/Level_3.tscn', 'res://Scenes/Level_4/Level_4.tscn'
]

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_current_level()

func _on_level_complete():
	current_level += 1
	$Level.queue_free()
	remove_child($Level)
	_load_current_level()

func _load_current_level():
	var level = load(levels[current_level % len(levels)]).instance()
	level.connect("complete", self, "_on_level_complete")
	add_child(level)
	
func show_menu():
	get_tree().paused = true	
	###############################################################
	var menu = preload('res://Scenes/Menu.tscn').instance()
	add_child(menu);
	###############################################################
	var result = yield(menu, "button_pressed")
	if result == "continue":
		yield(get_tree(), "idle_frame")
		get_tree().paused = false	
		menu.queue_free()
	if result == "exit":
		$Level.queue_free()
		yield($Level, "tree_exited")
		quit_game()

func quit_game():
	get_tree().quit()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
