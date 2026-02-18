extends Node2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.Shitok_around = true
		$"../../CanvasLayer/Help_label".visible = true
		$"../../CanvasLayer/Help_label".text = "light COMMAND TO TERMINAL"

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.Shitok_around = false
		$"../../CanvasLayer/Help_label".visible = false
		$"../../CanvasLayer/Help_label".text = "light COMMAND TO TERMINAL"

func _on_timer_timeout() -> void:
	if $Light.enabled:
		$Light.enabled = false
	else:
		$Light.enabled = true
