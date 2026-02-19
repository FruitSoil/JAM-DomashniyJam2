extends TextEdit

var keys: Array
var radio: bool = false
var moving:bool = false

func _ready() -> void:
	$"../..".visible = true
	blink()
	$"..".position = Vector2(833.0,614.0)

func _process(delta: float) -> void:
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
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 1).from(Vector2(833,210))
			await get_tree().create_timer(0.05).timeout
			radio = false
			$".".editable = false
	
	if Input.is_action_just_released("Radio_toggle"):
		if radio == true:
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 1).from(Vector2(833,210))
			await get_tree().create_timer(0.05).timeout
			radio = false
			$".".editable = false
		elif !moving:
			text = str("")
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833,210), 1).from(Vector2(833.0,614.0))
			$".".editable = true
			radio = true
			$".".grab_focus()


func blink():
	var twm = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 1.0), 0.3).from(Color(1.0, 1.0, 1.0, 0.0))
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 0.0), 0.3).from(Color(1.0, 1.0, 1.0, 1.0))

func _on_blink_timeout() -> void:
	$"../../Blink".start(randf_range(15,120))
	blink()

func apply_comand(type: int):
	if type == 1:
		text = text.substr(0, text.length() - 1)
	
	$"../Console".lines_skipped += 1
	if text == "light" and $"../../../../Player".Shitok_around:
		get_tree().call_group("togglable_light", "switch_light")
		$"../../../../Player".lights()
		blink()
		%Console.text = %Console.text + "\n" + "LIGHT SWITCHED!"
		%Console.lines_skipped += 1
		wait_fo_it()
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
