extends TextEdit

var keys: Array
var radio: bool = false

func _ready() -> void:
	$"../..".visible = true
	blink()
	$"..".position = Vector2(833.0,1000)

func _process(delta: float) -> void:
	if Input.is_action_just_released("enter"):
		$"../Console".lines_skipped += 1
		text = text.substr(0, text.length() - 1)
		if text == "flash":
			var twm = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
			twm.tween_property($"../../../../CanvasModulate","color",Color(0.11, 0.141, 0.106, 1.0),1).from(Color(2.313, 2.313, 2.313, 1.0))
			blink()
		for i in keys:
			if i == text:
				get_tree().call_group("Interactable", "object_action", i)
		print(text)
		%Console.text = %Console.text + "\n" + str(text)
		text = str("")


	if Input.is_action_just_released("Radio_toggle"):
		if radio == true:
			text = str("")
			await get_tree().process_frame
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833.0,1000), 1).from(Vector2(833,210))
			radio = false
		else:
			text = str("")
			await get_tree().process_frame
			var twp = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			twp.tween_property($"..","position",Vector2(833,210), 1).from(Vector2(833.0,1000))
			radio = true


func blink():
	var twm = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 1.0), 0.3).from(Color(1.0, 1.0, 1.0, 0.0))
	twm.tween_property($"../../Dark","modulate",Color(1.0, 1.0, 1.0, 0.0), 0.3).from(Color(1.0, 1.0, 1.0, 1.0))
