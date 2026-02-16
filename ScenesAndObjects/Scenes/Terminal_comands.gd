extends TextEdit


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_released("enter"):
		match text:
			"ss":
				$"../Dark".visible = false
				$"../../..".cam_pos = $Emploee
				
		print(text)
		text = str("")
