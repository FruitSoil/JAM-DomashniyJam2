extends CharacterBody2D

@onready var agent = $Navi as NavigationAgent2D
const Speed = 100.0

func _physics_process(delta: float) -> void:
	velocity = Speed * to_local(agent.get_next_path_position()).normalized()
	move_and_slide()
	

func _on_timer_timeout() -> void:
	agent.target_position = $"../Player".global_position
	if agent.is_target_reachable() == false:
		$Timer.wait_time = 2
		agent.target_position = global_position + Vector2(randf_range(-100,100),randf_range(-100,100))
	else:
		$Timer.wait_time = 0.2
