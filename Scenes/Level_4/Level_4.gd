extends "res://Scenes/Shared/BaseLevel.gd"


var nonono_text = [
	"#Нет нет нет. Я могу намного лучше."
]

var mission_text_1 = [
	")Мы убиваем себя, работаем все больше, наслаждаемся жизнью все меньше.", 
	")Все ради горы продуктов, потребления которой не приносит нам радости.",
	
]

var mission_text_2 = [
	")Простые люди покупают вещь — и радуются. А безудержное потребление убивает эту радость."
]

var mission_text_3 = [
	")Да будет жизнь простой, да будет она от чистого сердца."
]

var mission_text_4 = [
	"-."
]

var mission_text_5 = [
	"#Оператор.",	
	"$Оператор.",
	"#Наверное то что произошло было важно.",
	"#Ну что б я сдох если хоть что нибудь понял."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	music = [
		preload("res://Assets/Sounds/Daft Punk - Get Lucky (Dualtrax Chiptune Cover)-93087327.mp3"), 
		preload("res://Assets/Sounds/Chiptune-148861894.mp3")
	]
	mines = 5
	bg_frame = 3
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
			$ShotSFX.play()
			yield(_show_text(mission_text_4), "completed")
			_mission(part+1)
			return
		6:
			yield(_play_final_screen(), "completed")
			while (yield(Events, "event")["owner"] != "mouse"):
				pass
			_mission(part+1)
			return
		7:
			yield(_show_text(mission_text_5), "completed")
			_mission(part+1)
			return
		_:
			emit_signal("complete")
			return 
