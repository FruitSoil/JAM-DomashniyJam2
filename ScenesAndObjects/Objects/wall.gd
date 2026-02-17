extends StaticBody2D

var key: String = "door"
var locked = true

func _ready() -> void:
	key = "D" + str(randi_range(0,9)) + str(randi_range(0,9)) + str(randi_range(0,9))
	print(key)
	$Number.text = key
	$Number2.text = key
	$"../../CanvasLayer/Control/Radio/Terminal".keys.append(key)

func object_action(given_key: String):
	if given_key == key:
		if locked:
			locked = false
			$CollisionShape2D.disabled = true
			$PointLight2D.color = Color(0.0, 1.0, 0.0, 1.0)
		else:
			locked = true
			$CollisionShape2D.disabled = false
			$PointLight2D.color = Color(0.672, 0.001, 0.791, 1.0)
	
