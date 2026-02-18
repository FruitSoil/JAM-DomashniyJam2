extends TextEdit

var keys: Array
var radio: bool = false

func _ready() -> void:
	$"../..".visible = true
	blink()
	$"..".position = Vector2(833.0,614.0)

func _process(delta: float) -> void:
	if Input.is_action_just_released("enter") and radio == true:
		apply_comand(1)
	if Input.is_action_just_released("Radio_toggle") and radio == true:
		apply_comand(2)

	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right") or Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Down"):
		if radio == true:
			$".".editable = false
			text = str("")
			await get_tree().process_frame
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 1).from(Vector2(833,210))
			radio = false
	if Input.is_action_just_released("Radio_toggle"):
		if radio == true:
			$".".editable = true
			text = str("")
			await get_tree().process_frame
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,614.0), 1).from(Vector2(833,210))
			radio = false
		else:
			text = str("")
			await get_tree().process_frame
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833,210), 1).from(Vector2(833.0,614.0))
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
		wait_fo_it()
		get_tree().call_group("togglable_light", "switch_light")
		$"../../../../Player".lights()
		blink()
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
