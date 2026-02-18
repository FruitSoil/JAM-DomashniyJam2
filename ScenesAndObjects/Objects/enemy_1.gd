extends CharacterBody2D

@onready var agent = $Navi as NavigationAgent2D
const Speed = 80

func _physics_process(delta: float) -> void:
	velocity = Speed * to_local(agent.get_next_path_position()).normalized()
	move_and_slide()
	if agent.target_reached:
		_on_timer_timeout()

func _on_timer_timeout() -> void:
	agent.target_position = $"../Player".global_position
	if agent.is_target_reachable() == false:
		$Timer.wait_time = 2
		agent.target_position = global_position + Vector2(randf_range(-300,300),randf_range(-300,300))
	else:
		$Timer.wait_time = 1

func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.damage()
