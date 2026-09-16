extends Node2D



func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/main_menu.tscn")
