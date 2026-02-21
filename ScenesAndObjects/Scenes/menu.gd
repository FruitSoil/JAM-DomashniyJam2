extends Node2D

var s: String
func _ready() -> void:
	$AnimationPlayer.play("Starting_animation")
	$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
	if Global.money > 0:
		$UI/Control/Variables/Help.visible = true
	await get_tree().process_frame
	if Global.flashlight:
		$UI/Control/Label/icon_lock4.texture = load("res://Images/Icon_unlock.png")
	if Global.scanner:
		$UI/Control/Label/icon_lock5.texture = load("res://Images/Icon_unlock.png")
	if Global.headphones:
		$UI/TextureRect.texture = load("uid://ch4q2vw6m3axw")
		$UI/Control/Label/icon_lock6.texture = load("res://Images/Icon_unlock.png")
	if Global.garden:
		$UI/Control/Label/icon_lock2.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label/ColorRect.visible = false
		$UI/Control/Label/ColorRect2.visible = false
		$UI/Control/Label/ColorRect3.visible = false
		$UI/Control/Label/ColorRect4.visible = false
		$UI/Control/Label/icon_lock3.modulate = Color("ff3300")

func exit(location: int):
	match location:
		1:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/location.tscn")
		0:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/guide_location.tscn")
		2:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/Garden.tscn")
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
			"GUIDE":
				$AnimationPlayer.play("End_animation_2")
			"OFFICES":
				$AnimationPlayer.play("End_animation")
			"BOTANICAL-GARDEN":
				if Global.garden:
					$AnimationPlayer.play("End_animation_3")
				else:
					if Global.money >= 400:
						$UI/TextEdit.placeholder_text = "Botanical garden avaiable!"
						$UI/TextEdit.text = ""
						$Buy_sound.play()
						Global.garden = true
						$UI/Control/Label/icon_lock2.texture = load("uid://bbpjas7kc5c6o")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"SERVER-COOLING-ROOM":
				$UI/TextEdit.placeholder_text = "NOT AVIABLE RIGHT NOW"
				$UI/TextEdit.text = ""
			"FLASHLIGHT":
				if Global.flashlight:
					$UI/TextEdit.placeholder_text = "You already have it"
					$UI/TextEdit.text = ""
				else:
					if Global.money >= 150:
						$UI/TextEdit.placeholder_text = "You buy flashlight, use command POST-LIGHT in complex to activate it"
						$UI/TextEdit.text = ""
						Global.flashlight = true
						$Buy_sound.play()
						$UI/Control/Label/icon_lock4.texture = load("uid://bbpjas7kc5c6o")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"SCANNER":
				if Global.scanner:
					$UI/TextEdit.placeholder_text = "You already have it"
					$UI/TextEdit.text = ""
				else:
					if Global.money >= 250:
						$UI/TextEdit.placeholder_text = "You buy scanner, use command CHECK in complex to use scan"
						$UI/TextEdit.text = ""
						Global.scanner = true
						$Buy_sound.play()
						$UI/Control/Label/icon_lock5.texture = load("uid://bbpjas7kc5c6o")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"HEADPHONES":
				if Global.headphones:
					$UI/TextEdit.placeholder_text = "You already have it"
					$UI/TextEdit.text = ""
				else:
					if Global.money >= 200:
						$UI/TextureRect.texture = load("uid://ch4q2vw6m3axw")
						$UI/TextEdit.placeholder_text = "You buy headphones, use command TUNE in complex to music"
						$UI/TextEdit.text = ""
						Global.headphones = true
						$Buy_sound.play()
						$UI/Control/Label/icon_lock6.texture = load("uid://bbpjas7kc5c6o")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"I.N.K.":
				$UI/TextEdit.text = "Money, if that makes more sense"
			"A.K.O.D.Y.":
				$UI/TextEdit.text = "A.K.O.D.Y. - freaks"
			"CRIMENOIRBLOODGODFLEXFATWINTERDRUNKWIZARDCHRISTS.COM":
				$UI/TextEdit.text = "fuh, Nikogda tak mnogo ne pisal"
			"START":
				$UI/TextEdit.placeholder_text = "Check commands to play"
				$UI/TextEdit.text = ""
			"PLAY":
				$UI/TextEdit.placeholder_text = "Check commands to play"
				$UI/TextEdit.text = ""
			"EXIT":
				$UI/TextEdit.placeholder_text = "dont leave pls"
				$UI/TextEdit.text = ""
			"KRILLER":
				$UI/TextEdit.placeholder_text = "INK added"
				Global.money += 500
				_ready()
				$UI/TextEdit.text = ""
			_:
				$UI/TextEdit.placeholder_text = "COMMAND NOT FOUND"
				$UI/TextEdit.text = ""

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		$AudioStreamPlayer3.pitch_scale = 1.0
		$AudioStreamPlayer3.play()
