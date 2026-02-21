extends TextEdit

var keys: Array
var radio: bool = false
var moving:bool = false

func _ready() -> void:
	$"../..".visible = true
	blink()
	$"..".position = Vector2(833.0,614.0)

func _process(delta: float) -> void:
	if radio:
		Engine.time_scale = 0.7
	else:
		Engine.time_scale = 1.0
	
	if Input.is_action_pressed("Down") or Input.is_action_pressed("Up") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		moving = true
	else:
		moving = false
	
	if Input.is_action_just_released("enter") and radio == true:
		apply_comand(1)
	if Input.is_action_just_released("Radio_toggle") and radio == true:
		apply_comand(2)
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right") or Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Down"):
		if radio == true:
			$"../terminal2".play()
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 0.6).from(Vector2(833,210))
			await get_tree().create_timer(0.05).timeout
			radio = false
			$".".editable = false
	
	if Input.is_action_just_released("Radio_toggle"):
		
		if radio == true:
			$"../terminal2".play()
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 0.6).from(Vector2(833,210))
			await get_tree().create_timer(0.05).timeout
			radio = false
			$".".editable = false
		elif !moving:
			$"../terminal".play()
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833,210), 0.6).from(Vector2(833.0,614.0))
			$".".editable = true
			radio = true
			$".".grab_focus()


func blink():
	var twm = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 1.0), 0.3).from(Color(1.0, 1.0, 1.0, 0.0))
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 0.0), 0.3).from(Color(1.0, 1.0, 1.0, 1.0))

func _on_blink_timeout() -> void:
	var timer = ($"../../../../Player".hp * 30) + randf_range(5,30)
	$"../../Blink".start(timer) 
	blink()

func apply_comand(type: int):
	if type == 1:
		text = text.substr(0, text.length() - 1)
	
	$"../Console".lines_skipped += 1
	text = text.to_upper()
	if text == "HELP":
		%Console.text = %Console.text + "\n" + "   PORT-LIGHT"
		%Console.lines_skipped += 1
		%Console.text = %Console.text + "\n" + "Switch flashlight\n(if has flashlight)"
		%Console.lines_skipped += 2
		%Console.text = %Console.text + "\n" + "   CHECK"
		%Console.lines_skipped += 1
		%Console.text = %Console.text + "\n" + "Start scan programm\n(if has scanner)"
		%Console.lines_skipped += 2
		%Console.text = %Console.text + "\n" + "   TUNE"
		%Console.lines_skipped += 1
		%Console.text = %Console.text + "\n" + "Put on/take off headphones\n(if has headphones)"
		%Console.lines_skipped += 2
	if text == "PORT-LIGHT" and Global.flashlight:
		$"../../../../Player".toggle_flash()
	if text == "LIGHT" and $"../../../../Player".Shitok_around:
		get_tree().call_group("togglable_light", "switch_light")
		$"../../../../Player".lights()
		blink()
		%Console.text = %Console.text + "\n" + "LIGHT SWITCHED!"
		%Console.lines_skipped += 1
		wait_fo_it()
	if text == "CHECK" and Global.scanner:
		if $"../../../../Player".scanner_coldown <= 0:
			$"../../../../Player".scanner()
			%Console.text = %Console.text + "\n" + "SCANNING"
			%Console.lines_skipped += 1
		else:
			%Console.text = %Console.text + "\n" + "Cooldown"
			%Console.lines_skipped += 1
	if text == "TUNE" and Global.headphones:
		$"../../../../Player".music_toggle()
		%Console.text = %Console.text + "\n" + "Headphones sound\nswitched"
		%Console.lines_skipped += 2
	for i in keys:
		if i == text:
			get_tree().call_group("Interactable", "object_action", i)
	print(text)
	%Console.text = %Console.text + "\n" + str(text)
	text = str("")

func wait_fo_it():
	await get_tree().create_timer(randf_range(30,100)).timeout
	get_tree().call_group("togglable_light", "switch_light")
	$"../../../../Player".lights()
	blink()

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo() and get_viewport().gui_get_focus_owner() == self and editable:
		$"../Click_sound".pitch_scale = randf_range(0.9,1.1)
		$"../Click_sound".play()
