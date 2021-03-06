extends "res://Scenes/Shared/BaseLevel.gd"

var nonono_text = [
	"#Нет нет нет. Я могу намного лучше."
]

var mission_text_1 = [
	"@Отличная работа сержант, но наша работа не закончена.",
	"@Отправляйся на територию и убедись что там все чисто.",
	"#Разрешите выполнять задание, товарищ полковник?",
	"@Разрешаю. Желаю удачи."
]

var mission_text_2 = [
	"$Сержант вам входящий.",
	"#Соединяйте.",
	"&Привет Брат.",
	"&Я подумал раз ты сейчас не дома...",
	"&... то я могу взять твою приставку поиграть.",
	"#ПОСЛЕ ВСЕГО ЧТО ТЫ НАГОВОРИЛ ПРО МЕНЯ МАМЕ?!!!",
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
			_mission(part+1)
			return
		1:
			_setup_gameplay(music[0])
			if yield(_play(), "completed"):
				_mission(part+1)
				return
			else:
				yield(_show_text(nonono_text), "completed")
				_mission(part)
				return
		2:
			yield(_show_text(mission_text_2), "completed")
			_mission(part+1)
			return
		3:
			_setup_gameplay(music[1])
			if yield(_play(), "completed"):
				_mission(part+1)
				return
			else:
				yield(_show_text(nonono_text), "completed")
				_mission(part)
				return
		4:
			yield(_show_text(mission_text_3), "completed")
			_mission(part+1)
			return
		5:
			yield(_play_final_screen(), "completed")
			while (yield(Events, "event")["owner"] != "mouse"):
				pass
			_mission(part+1)
			return
		_:
			emit_signal("complete")
			return 
