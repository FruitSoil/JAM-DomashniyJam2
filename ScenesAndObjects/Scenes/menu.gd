extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("Starting_animation")
	$UI/Control/Variables.text = "I.N.K.:\n  " + str(Global.money)

func exit(location: int):
	match location:
		1:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/location.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and $AnimationPlayer.current_animation == "Starting_animation":
		$AnimationPlayer.play("RESET")
		await get_tree().process_frame
		$UI/Control/TextureRect.visible = false
	
	if Input.is_action_just_pressed("enter"):
		$UI/TextEdit.text = $UI/TextEdit.text.substr(0, $UI/TextEdit.text.length() - 1)
		match $UI/TextEdit.text:
			"OFFICES":
				$AnimationPlayer.play("End_animation")
			"BOTANICAL-GARDEN":
				$UI/TextEdit.text = "NOT AVIABLE RIGHT NOW"
			"SERVER-COOLING-ROOM":
				$UI/TextEdit.text = "NOT AVIABLE RIGHT NOW"
			"FLASHLIGHT":
				$UI/TextEdit.text = "NOT AVIABLE RIGHT NOW"
			"SCANNER":
				$UI/TextEdit.text = "NOT AVIABLE RIGHT NOW"
			"HEADPHONES":
				$UI/TextEdit.text = "NOT AVIABLE RIGHT NOW"
			"I.N.K.":
				$UI/TextEdit.text = "Money, if that makes more sense"
			"A.K.O.D.Y.":
				$UI/TextEdit.text = "A.K.O.D.Y. - freaks"
			_:
				$UI/TextEdit.text = "COMMAND NOT FOUND"

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		$AudioStreamPlayer3.pitch_scale = 1.0
		$AudioStreamPlayer3.play()
