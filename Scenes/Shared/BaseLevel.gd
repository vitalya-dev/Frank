extends Control

# Declare member variables here. Examples
export(int) var scores_in_sec = 50
export(int) var mines = 5
export (int) var bg_frame = 0

var music = []

signal complete()
signal fail()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _start_level():
	#$Music.pitch_scale = 10
	$Score.visible = false
	$BG.show_default(bg_frame)
	yield(get_tree(), "idle_frame")
	_mission(0)

func _mission(part):
	pass

func _input(ev):
	if ev.is_action_pressed("ui_cancel"):
		_esc_pressed()

func _esc_pressed():
	get_node("/root/Game").show_menu() 

func _play_final_screen():
	$Field.visible = false
	$BG.show_glory()
	#===========================#
	$VictorySFX.play()
	yield($VictorySFX, "finished")

func _play_credits_screen():
	$Field.visible = false
	$BG.show_credits()
	#===========================#
	$VictorySFX.play()
	yield($VictorySFX, "finished")


func _prepare_field(mines):
	$Field.reset()
	$Field.distribute_mines(mines)
	$Field.get_safty_tile().swing()
	$OpenSFX.play()

func _setup_gameplay(music):
	$Music.stream = music
	$Score.reset()
	$Score.max_value = music.get_length() * scores_in_sec

func _play():
	$Score.visible = true
	$Music.play()
	$Music.fade_in()
	while $Music.is_playing() and $Score.value < $Score.max_value:
		_prepare_field(mines)
		if (yield(_solve(), "completed")):
			$VictorySFX.play()
			yield($VictorySFX, "finished")
			continue
		else:
			$BG.show_explosion()
			#===========================#
			$FireSFX.play()
			yield($FireSFX, "finished")
			#===========================#
			$BG.show_default(bg_frame)
			#===========================#
			continue
	$Score.visible = false
	$Music.stop()
	return $Score.value >= $Score.max_value

func _solve():
	var _result = null
	##################################
	while true:
		var event = yield(Events, "event")
		_play_sfx(event)
		_add_score(event)
		if _failed(event):
			_result = false
			break
		elif _solved(event):
			_result = true
			break
	##################################
	return _result

func _failed(event):
	if event["owner"] == "music" and event["name"] == "finished":
		return true
	if event["name"] == "tile_open" and event["tile"].mine:
		return true
	return false

func _solved(event):
	if $Score.value >= $Score.max_value:
		return true
	if $Field.solved():
		return true
	return false

func _play_sfx(event):
	if event["owner"] == "field" and event["name"] == "tile_open":
		$OpenSFX.stop()
		$OpenSFX.play()
		$Voice.talk()
	elif event["owner"] == "field" and (event["name"] == "tile_flag" or event["name"] == "tile_unflag"):
		$FlagSFX.stop()
		$FlagSFX.play()
		$Voice.talk()

func _add_score(event):
	if event["name"] == "tile_open":
		$Score.score += 5
	elif event["name"] == "tile_flag":
		$Score.score += 1
	elif event["name"] == "tile_unflag":
		$Score.score += 1

func _show_text(text):
	_prepare_field(0)
	yield(_message_window(text), "completed")

func _message_window(messages):
	var message_window = preload('res://Scenes/Shared/MessageWindow.tscn').instance()
	message_window.get_node("Message").messages = messages
	message_window.get_node("Message").avatar_1 = preload("res://Assets/Graphics/Avatars/avatar_colonel.png")
	message_window.get_node("Message").avatar_2 = preload("res://Assets/Graphics/Avatars/avatar_sergeant.png")
	message_window.get_node("Message").avatar_3 = preload("res://Assets/Graphics/Avatars/avatar_operator.png")
	message_window.get_node("Message").avatar_4 = preload("res://Assets/Graphics/Avatars/avatar_mom.png")
	message_window.get_node("Message").avatar_5 = preload("res://Assets/Graphics/Avatars/avatar_bomber.png")
	message_window.get_node("Message").avatar_6 = preload("res://Assets/Graphics/Avatars/avatar_brother.png")
	message_window.get_node("Message").avatar_7 = preload("res://Assets/Graphics/Avatars/avatar_doctor.png")
	message_window.get_node("Message").avatar_8 = preload("res://Assets/Graphics/Avatars/avatar_wife.png")
	message_window.get_node("Message").avatar_9 = preload("res://Assets/Graphics/Avatars/avatar_ahmed.png")
	message_window.get_node("Message").avatar_10 = preload("res://Assets/Graphics/Avatars/avatar_ahmed_dead.png")
	add_child(message_window, true);
	yield(message_window, "tree_exited")
