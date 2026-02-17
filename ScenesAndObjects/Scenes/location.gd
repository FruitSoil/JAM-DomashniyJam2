extends Node2D

@onready var target = $Player

func _process(delta: float) -> void:
	if Input.is_action_pressed("targ_en"):
		target = $Enemy_1
	else:
		target = $Player
	$Camera2D.global_position.x = lerpf($Camera2D.global_position.x,target.global_position.x, 0.03)
	$Camera2D.global_position.y = lerpf($Camera2D.global_position.y,target.global_position.y, 0.03)
