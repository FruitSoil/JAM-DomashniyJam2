extends Node2D

@onready var cam_pos = $Emploee

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	$Camera2D.global_position = cam_pos.global_position
