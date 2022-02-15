extends "res://Scenes/Shared/BaseLevel.gd"

var mission_text_1 = [
	"@Замечательная работа Сержант.",
	"@Последний заход.",
	"@Будьте осторожны."
]

var mission_text_2 = [
	"$Сержант вам входящий.",
	"#Соединяйте.",
	"%Скотина!",
	"%Ты почему не дал ребенку то о чем он тебя просил, чудовище?",
	"%Из за тебя мой птенчик грустит!",
	"%Подонок.",
	"$Соединение прервано.",
	"#...!",
	"#За что мне все вот это вот?"
]

var mission_text_3 = [
	"#Оператор.",
	"$Оператор.",
	"#Да. Соедините меня с моим братом.",
	"&Алло?",
	"#Мурло!",
	"#Можешь взять приставку."
]

var mission_text_4 = [
	"@Cержант.",
	"#Домой, товарищ полковник?",
	"#...",
	"#Полковник?",
	"@Cержант.",
	"@Зови меня...",
	")...Ахмед ибн Юсуф."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	music = [
		preload("res://Assets/Sounds/The Gauntlet [POKEY Original]-714991828.mp3"), 
		preload("res://Assets/Sounds/Bounty Battle - Animated Trailer theme-892202470.mp3")
	]
	mines = 5
	bg_frame = 2
	_start_level()

func _mission(part):
	if is_queued_for_deletion():
		return
	match part:
		0:
			yield(_show_text(mission_text_1), "completed")
			$Music.stream = music[0]			
			$Music.play()
			$Music.fade_in()
			_mission(part+1)
			return
		1:
			yield(_play_while_music_play(), "completed")
			_mission(part+1)
			return
		2:
			yield(_show_text(mission_text_2), "completed")
			$Music.stream = music[2]
			$Music.play()
			$Music.fade_in()
			_mission(part+1)
			return
		3:
			yield(_play_while_music_play(), "completed")
			_mission(part+1)
			return
		4:
			yield(_show_text(mission_text_3), "completed")
			_mission(part+1)
			return
		5:
			yield(_play_final_screen(), "completed")
			_stamped_mark()
			while (yield(Events, "event")["owner"] != "mouse"):
				pass
			_mission(part+1)
			return
		6:
			yield(_show_text(mission_text_4), "completed")
			_mission(part+1)
			return
		_:
			emit_signal("complete")
			return 
