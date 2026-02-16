extends Area2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func disable():
	$CollisionShape2D.disabled = true
