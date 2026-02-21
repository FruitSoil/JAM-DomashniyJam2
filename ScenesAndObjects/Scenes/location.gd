extends Node2D

@onready var target = $Player

func _ready() -> void:
	$Camera.global_position = target.global_position
	$CanvasModulate.visible = true

func _process(delta: float) -> void:
	if $Player.current_money >= 300:
		$CanvasLayer/Quota.add_theme_color_override("font_color",Color("00b610ff"))
	if Input.is_action_pressed("targ_en"):
		target = $Enemy_1
	else:
		target = $Player
	
	
	%Ambient_parts.global_position = target.global_position
	%Ambient_parts2.global_position = target.global_position
	$Camera.global_position.x = lerpf($Camera.global_position.x,target.global_position.x, 0.03)
	$Camera.global_position.y = lerpf($Camera.global_position.y,target.global_position.y, 0.03)

func _on_timer_timeout() -> void:
	$Player_sprite.global_position = $Player.global_position
	$Player_sprite/Timer.wait_time = randf_range(0.01, 0.1)

func _pcik() -> void:
	if $CanvasLayer/Control/Radio/Terminal.placeholder_text == "/":
		$CanvasLayer/Control/Radio/Terminal.placeholder_text = " "
	else:
		$CanvasLayer/Control/Radio/Terminal.placeholder_text = "/"


func _on_tutorial_area_exited(area: Area2D, extra_arg_0: int) -> void:
	pass # Replace with function body.
