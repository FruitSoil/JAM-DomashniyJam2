extends Node2D

var s: String
func _ready() -> void:
	$AnimationPlayer.play("Starting_animation")
	$UI/Control/Variables.text = "I.N.K.:\n  " + str(Global.money)
	if Global.money > 0:
		$UI/Control/Variables/Help.visible = true

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
		$UI/TextEdit.text = $UI/TextEdit.text.to_upper()
		print($UI/TextEdit.text)
		match $UI/TextEdit.text:
			"OFFICES":
				$AnimationPlayer.play("End_animation")
			"BOTANICAL-GARDEN":
				$UI/TextEdit.placeholder_text = "NOT AVIABLE RIGHT NOW"
				$UI/TextEdit.text = ""
			"SERVER-COOLING-ROOM":
				$UI/TextEdit.placeholder_text = "NOT AVIABLE RIGHT NOW"
				$UI/TextEdit.text = ""
			"FLASHLIGHT":
				$UI/TextEdit.placeholder_text = "NOT IN STORE YET"
				$UI/TextEdit.text = ""
			"SCANNER":
				$UI/TextEdit.placeholder_text = "W.I.P"
				$UI/TextEdit.text = ""
			"HEADPHONES":
				$UI/TextEdit.placeholder_text = "NOT IN STORE YET"
				$UI/TextEdit.text = ""
			"I.N.K.":
				$UI/TextEdit.text = "Money, if that makes more sense"
			"A.K.O.D.Y.":
				$UI/TextEdit.text = "A.K.O.D.Y. - freaks"
			"crimenoirbloodgodflexfatwinterdrunkwizardchrists.com":
				$UI/TextEdit.text = "fuh, Nikogda tak mnogo ne pisal"
			"EXIT":
				$UI/TextEdit.text = "don't leave pls"
			_:
				$UI/TextEdit.placeholder_text = "COMMAND NOT FOUND"
				$UI/TextEdit.text = ""

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		$AudioStreamPlayer3.pitch_scale = 1.0
		$AudioStreamPlayer3.play()
