extends CharacterBody2D

@onready var agent = $Navi as NavigationAgent2D
@export var Speed = 80
var agressive:bool = false

func _physics_process(delta: float) -> void:
	velocity = Speed * to_local(agent.get_next_path_position()).normalized()
	move_and_slide()

func _on_timer_timeout() -> void:
	if agressive:
		agent.target_position = $"../Player".global_position
		if agent.is_target_reachable() == false:
			$Timer.wait_time = 2
			agent.target_position = global_position + Vector2(randf_range(-300,300),randf_range(-300,300))
		else:
			$Timer.wait_time = 0.5
	else:
		agent.target_position = global_position + Vector2(randf_range(-300,300),randf_range(-300,300))

func _on_damage_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.damage()
		call_deferred("disable")

func disable():
		$Damage_zone/Collision.disabled = true
		$attack_timer.start()

func _on_visible_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		agressive = true
func _on_visible_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		agressive = false

func _on_attack_timer_timeout() -> void:
	$Damage_zone/Collision.disabled = false

func _on_damage_zone_area_entered(area: Area2D) -> void:
	if area.name == "scanner":
			$Sprite.material.set_light_mode(1)
			print("loot_scanned")
			await get_tree().create_timer(randf_range(0,0.5)).timeout
			$Scan_sound.play()

func _on_damage_zone_area_exited(area: Area2D) -> void:
	$Sprite.material.set_light_mode(2)
	print("loot_unscanned")
