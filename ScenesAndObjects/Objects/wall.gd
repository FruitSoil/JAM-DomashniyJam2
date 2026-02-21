extends StaticBody2D

var key: String = "door"
var locked = true
var numbe: Array = ["X","C",""]
@export var lock_lvl = 2
@export var lock_lock = false

func _ready() -> void:
	number_roll()

func number_roll():
	if lock_lock == false:
		lock_lvl = randi_range(1,3)
	match lock_lvl:
		1:
			key = numbe.get(randi_range(0,2)) + str(randi_range(0,8))
		2:
			key = numbe.get(randi_range(0,2)) + str(randi_range(0,8)) + str(randi_range(0,8))
		3:
			key = numbe.get(randi_range(0,2)) + str(randi_range(0,8)) + str(randi_range(0,8)) + str(randi_range(0,8))
	print(key)
	$Number.text = key
	$Number2.text = key
	if $"../../CanvasLayer/Control/Radio/Terminal".keys.has(key) == false:
		$"../../CanvasLayer/Control/Radio/Terminal".keys.append(key)
	else:
		number_roll()

func object_action(given_key: String):
	if given_key == key:
		if locked:
			$Sprite2D2.texture = load("uid://doubxhh346jsy")
			locked = false
			$CollisionShape2D.disabled = true
			var twc = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
			twc.tween_property($PointLight2D, "color", Color(0.0, 1.0, 0.0, 1.0), 0.2)
			$LightOccluder2D.set_occluder_light_mask(0)
			%Console.text = %Console.text + "\n" + "DOOR OPEN!"
			%Console.lines_skipped += 1
			$Open.play()
			$Close.play()
		else:
			$Sprite2D2.texture = load("uid://cbfu02h0nci80")
			locked = true
			$LightOccluder2D.set_occluder_light_mask(1)
			$CollisionShape2D.disabled = false
			var twc = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN)
			twc.tween_property($PointLight2D, "color", Color(1.0, 0.0, 0.0, 1.0), 0.2)
			%Console.text = %Console.text + "\n" + "DOOR CLOSE!"
			%Console.lines_skipped += 1
			$Close.play()
		print("new bake")
		$"..".bake_navigation_polygon()
