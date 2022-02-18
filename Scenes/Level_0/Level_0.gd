extends "res://Scenes/Shared/BaseLevel.gd"

var nonono_text = [
	"#Нет нет нет. Я могу намного лучше."
]


var mission_text_1 = [
	"@Добро пожаловать в симуляцию, сержант.",
	"@Пространство поделено на смежные ячейки.",
	"@Есть ячейки в которых установлена мина.",
	"@Твоя работа - открыть все ячейки не содержащие мину и пометить те в которых мина есть.",
	"@Ячейка в которой нет мины покажет тебе количество соседних ячеек в которых есть мина.",
	"@Используя эту информацию даже такой идиот как ты сможет все сделать правильно.",
	"@Используй левую кнопку мыши что бы открыть ячейку, используй правую кнопку что бы пометить ячейку.",
	"@Надеюсь все ясно?"
]

var mission_text_2 = [
	"@Мы спрятали пару мин на учебном полигоне, сержант.",
	"@Найди их!",
	"@Первая безопасная ячейка крутится.",
	"@Всегда начинай с нее!",
	"@Развлекайся, пока играет музыка.",
	"@По результатам твоей работы тебе будет выставлена оценка"
]

var mission_text_3 = [
	"@Очень хорошо. Собирай вещи. Вылет через пару часов.",
	"#Что? Куда?"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	music = [preload("res://Assets/Sounds/Gravity Falls Opening (8-Bit Remix)-54452827.mp3")]
	mines = 2
	bg_frame = 0
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
			yield(_show_text(mission_text_2), "completed")
			_mission(part+1)
			return
		2:
			_setup_gameplay(music[0])
			if yield(_play(), "completed"):
				_mission(part+1)
				return
			else:
				yield(_show_text(nonono_text), "completed")
				_mission(part)
				return
		3:
			yield(_play_final_screen(), "completed")
			while (yield(Events, "event")["owner"] != "mouse"):
				pass
			_mission(part+1)
			return	
		4:
			yield(_show_text(mission_text_3), "completed")
			_mission(part+1)
			return
		_:
			emit_signal("complete") 
			return
