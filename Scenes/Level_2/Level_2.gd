extends "res://Scenes/Shared/BaseLevel.gd"

var mission_text_1 = [
	"@Отличная работа сержант, но наша работа не закончена.",
	"@Отправляйся на територию под мусорный полигон и убедись что там все чисто.",
	"#Разрешите выполнять задание, товарищ полковник?",
	"@Разрешаю. Желаю удачи."
]

var mission_text_2 = [
	"$Сержант вам входящий.",
	"#Соединяйте.",
	"&Привет Брат.",
	"#Ну погоди. Ну все. Устрою тебе.",
	"&А что я такого сделал?",
	"#Кто сказал маме что я на курорте?",
	"#Отдыхаю под солнышком?",
	"&Да ничего я такого ей не говорил.",
	"&Она спросила где ты я ответил а она что то себе придумала.",
	"&Да я вообще не поэтому звоню.",
	"#Не по этому он звонит. Что ты еще натворил?",
	"&Да что ты в самом деле. Я просто подумал раз ты сейчас не дома...",
	"&... то я могу взять твою приставку поиграть.",
	"#ПОСЛЕ ВСЕГО ЧТО ТЫ СДЕЛАЛ?!!!",
	"$Соеденение прервано.",
	"#Трубку повесил. Ну все. Я ему устрою. Ну все."
]

var mission_text_3= [
	"$Сержант вам входящий.",
	"(Привет любимый.",
	"(Твой брат заходил.",
	"(Взял твою дурацкую приставку. Сказал что ты разрешил.",
	"(И еще съел все вафли маленького.",
	"#Ну все..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	music = [preload("res://Assets/Sounds/8 Bit Adventure.mp3"), preload("res://Assets/Sounds/Algar - Demomans Adventure-204087543.mp3")]
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
