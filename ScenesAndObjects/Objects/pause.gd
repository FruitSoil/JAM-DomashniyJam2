extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		if get_tree().paused == true:
			await get_tree().create_timer(0.1,true).timeout
			get_tree().paused = false
			$Label.visible = false
		elif $"../Death_UI".visible == false:
			await get_tree().create_timer(0.1,true).timeout
			get_tree().paused = true
			$Label.visible = true

func _on_button_pressed() -> void:
	$Label/Exit_comfirm.visible = true

func _on_exit_comfirm_confirmed() -> void:
	$"../Player".current_money = 0
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/menu.tscn")
