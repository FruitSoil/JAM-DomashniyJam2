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
