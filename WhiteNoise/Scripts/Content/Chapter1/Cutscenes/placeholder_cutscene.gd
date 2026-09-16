extends Panel

@onready var timer: Timer = $Timer

func _ready():
	timer.wait_time = 10
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Cutscenes/chapter_1_outro.tscn")
