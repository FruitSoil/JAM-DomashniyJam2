extends CanvasLayer

func _on_button_pressed() -> void:
	#в меню
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_button_pressed2() -> void:
	#в меню
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/menu.tscn")
