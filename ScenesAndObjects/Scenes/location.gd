extends Node2D

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	$Camera2D.global_position.x = lerpf($Camera2D.global_position.x,$Player.global_position.x, 0.01)
	$Camera2D.global_position.y = lerpf($Camera2D.global_position.y,$Player.global_position.y, 0.01)
