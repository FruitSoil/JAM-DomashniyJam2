extends CharacterBody2D

var Speed = 200.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if $"../CanvasLayer/Control/Radio/Terminal".radio == false:
		velocity = direction * Speed
	else:
		velocity = Vector2(0,0)
	move_and_slide()
