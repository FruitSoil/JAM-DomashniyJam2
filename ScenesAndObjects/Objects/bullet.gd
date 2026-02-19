extends Area2D

var speed = 2000   

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		body.damage()
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
