extends "res://Scenes/Shared/BaseLevel.gd"

var mission_text_1 = [
	"@Добро пожаловать в Алжир сержант.",
	"@Местные заминировали часть Сахары на подьезде к городу.",
	"@Наша задача - разминировать то что они заминировали.",
	"@Вопросы?",
	"#Никак нет.",
	"#Разрешите выполнять задание?",
	"@Разрешаю.",
	"@Желаю удачи."
]

var mission_text_2 = [
	"$Сержант вам входящий.",
	"#Соединяйте.",
	"%ТЫ ЧЕГО МНЕ НЕ ЗВОНИШЬ СКОТИНА?",
	"#Я на работе!!!",
	"%Ага на работе он. Твой брат все рассказал на какой ты работе.",
	"%Загораешь под солнцем и даже мать свою не пригласил.",
	"%Безсердечное ты животное.",
	"%Сердце кровью обливается от того что бывают такие неблагодарные дети.",
	"%Сукин ты сын...",
	"$Соеденение прервано.",
	"#Господи...",
]

var mission_text_3= [
	"$Сержант Вам входящий.",
	"%Надо было отдать тебя в детдом а еще лучше вообще не рожать!",
	"$Соеденение прервано.",
	"#...",
	"#Господи..."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	music = [preload("res://Assets/Sounds/ahoe.mp3"), preload("res://Assets/Sounds/Mimosa-697049527.mp3")]
	mines = 5
	bg_frame = 1
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
	`		yield(_play_while_music_play(), "completed")
			_mission(part+1)
			return
		2:
			yield(_show_text(mission_text_2), "completed")
			$Music.stream = music[1]
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
		_:
			emit_signal("complete")
			return 
