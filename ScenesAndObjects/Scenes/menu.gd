extends Node2D

var s: String
func _ready() -> void:
	Global.cur_loc = "n"
	$AnimationPlayer.play("Starting_animation")
	$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
	if Global.money > 0:
		$UI/Control/Variables/Help.visible = true
	await get_tree().process_frame
	if Global.flashlight:
		$UI/Control/Label_2/icon_lock4.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label_2/icon_lock4.modulate = Color("00ffff")
	if Global.scanner:
		$UI/Control/Label_2/icon_lock5.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label_2/icon_lock5.modulate = Color("00ffff")
	if Global.headphones:
		$UI/TextureRect.texture = load("uid://ch4q2vw6m3axw")
		$UI/Control/Label_2/icon_lock6.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label_2/icon_lock6.modulate = Color("00ffff")
	if Global.turret_hack:
		$UI/TextureRect.texture = load("uid://ch4q2vw6m3axw")
		$UI/Control/Label_2/icon_lock8.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label_2/icon_lock8.modulate = Color("00ffff")
	if Global.garden:
		$UI/Control/Label/icon_lock2.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label/icon_lock2.modulate = Color("00ffff")
		$UI/Control/Label/ColorRect.visible = false
		$UI/Control/Label/ColorRect2.visible = false
		$UI/Control/Label/ColorRect3.visible = false
		$UI/Control/Label/ColorRect4.visible = false
	if Global.servers:
		$UI/Control/Label/icon_lock3.texture = load("res://Images/Icon_unlock.png")
		$UI/Control/Label/icon_lock3.modulate = Color("00ffff")

func focus():
	$UI/TextEdit.grab_focus()

func exit(location: int):
	match location:
		1:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/location.tscn")
		0:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/guide_location.tscn")
		2:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/Garden.tscn")
		3:
			get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/Servers.tscn")

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and $AnimationPlayer.current_animation == "Starting_animation":
		$AnimationPlayer.play("RESET")
		await get_tree().process_frame
		$UI/Control/TextureRect.visible = false
		$UI/TextEdit.grab_focus()
	
	if Input.is_action_just_pressed("enter"):
		$UI/TextEdit.text = $UI/TextEdit.text.substr(0, $UI/TextEdit.text.length() - 1)
		$UI/TextEdit.text = $UI/TextEdit.text.to_upper()
		print("Player command ",$UI/TextEdit.text)
		match $UI/TextEdit.text:
			"GUIDE":
				$AnimationPlayer.play("End_animation_2")
				Global.cur_loc = "guide"
			"OFFICES":
				$AnimationPlayer.play("End_animation")
				Global.cur_loc = "offices"
			"BOTANICAL-GARDEN":
				if Global.garden:
					$AnimationPlayer.play("End_animation_3")
					Global.cur_loc = "garden"
				else:
					if Global.money >= 400:
						$UI/TextEdit.placeholder_text = "Botanical garden avaiable!"
						$UI/TextEdit.text = ""
						$Buy_sound.play()
						Global.garden = true
						Global.money -= 400
						$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
						$UI/Control/Label/icon_lock2.texture = load("uid://bbpjas7kc5c6o")
						$UI/Control/Label/icon_lock2.modulate = Color("00ffff")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"DATA-CENTER":
				if Global.servers:
					$AnimationPlayer.play("End_animation_4")
					Global.cur_loc = "Data"
				else:
					if Global.money >= 600:
						if Global.flashlight and Global.headphones and Global.scanner and Global.turret_hack: 
							$UI/TextEdit.placeholder_text = "Data center avaiable!"
							$UI/TextEdit.text = ""
							$Buy_sound.play()
							Global.servers = true
							Global.money -= 600
							$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
							$UI/Control/Label/icon_lock3.texture = load("uid://bbpjas7kc5c6o")
							$UI/Control/Label/icon_lock3.modulate = Color("00ffff")
						else:
							$UI/TextEdit.placeholder_text = "Not all items have been purchased"
							$UI/TextEdit.text = ""
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
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
						Global.money -= 150
						$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
						$Buy_sound.play()
						$UI/Control/Label_2/icon_lock4.texture = load("uid://bbpjas7kc5c6o")
						$UI/Control/Label_2/icon_lock4.modulate = Color("00ffff")
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
						Global.money -= 250
						$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
						$Buy_sound.play()
						$UI/Control/Label_2/icon_lock5.texture = load("uid://bbpjas7kc5c6o")
						$UI/Control/Label_2/icon_lock5.modulate = Color("00ffff")
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
						Global.money -= 200
						$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
						$Buy_sound.play()
						$UI/Control/Label_2/icon_lock6.texture = load("uid://bbpjas7kc5c6o")
						$UI/Control/Label_2/icon_lock6.modulate = Color("00ffff")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"TURRET-HACK":
				if Global.turret_hack:
					$UI/TextEdit.placeholder_text = "You already have it"
					$UI/TextEdit.text = ""
				else:
					if Global.money >= 350:
						$UI/TextEdit.placeholder_text = "You buy turret hack. Find turret and see its code"
						$UI/TextEdit.text = ""
						Global.turret_hack = true
						Global.money -= 350
						$UI/Control/Variables.text = "I.N.K.: " + str(Global.money)
						$Buy_sound.play()
						$UI/Control/Label_2/icon_lock8.texture = load("uid://bbpjas7kc5c6o")
						$UI/Control/Label_2/icon_lock8.modulate = Color("00ffff")
					else:
						$UI/TextEdit.placeholder_text = "Not enough I.N.K."
						$UI/TextEdit.text = ""
			"I.N.K.":
				$UI/TextEdit.text = "Money, if that makes more sense"
			"A.K.O.D.Y.":
				$UI/TextEdit.placeholder_text = "Akodians - freaks"
				$UI/TextEdit.text = ""
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
				$UI/TextEdit.placeholder_text = "INK added. Krillers are control AKODY and "
				Global.money += 1000
				_ready()
				$UI/TextEdit.text = ""
			"MAGONETE":
				$UI/TextEdit.placeholder_text = "UPGRADES given. Magonete hate augs if you wanna know"
				Global.scanner = true
				Global.flashlight = true
				Global.turret_hack = true
				Global.headphones = true
				Global.garden = true
				Global.servers = true
				_ready()
				$UI/TextEdit.text = ""
			"":
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
