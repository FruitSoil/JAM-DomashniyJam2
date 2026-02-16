extends CharacterBody2D

@onready var navigation = $NavigationAgent2D
var Speed = 100.0
var points_in_area: Array
var time_to_think: float

func _process(delta: float) -> void:
	var dir = to_local(navigation.get_next_path_position()).normalized()
	velocity = dir * Speed
	var angle = global_position.angle_to_point(navigation.get_next_path_position())
	$ray_casts.rotation = lerpf($ray_casts.rotation , angle, 0.05)
	move_and_slide()
	if $ray_casts/RayCast2D.is_colliding():
		print("ss")
		var collider = $ray_casts/RayCast2D.get_collider()
		collider.disable()
		points_in_area.erase(collider)

func _on_timer_timeout() -> void:
	if points_in_area.size() > 0:
		navigation.target_position = get_closest_point().global_position

func _on_points_zone_area_entered(area: Area2D) -> void:
	if area.has_meta("Point") and area.get_meta("Point") == true:
		points_in_area.append(area)
		print("added")

func _on_points_zone_area_exited(area: Area2D) -> void:
	if area.has_meta("Point") and area.get_meta("Point") == true:
		points_in_area.erase(area)
		print("erased")

func get_closest_point() -> Node2D:
	print(points_in_area)
	var closest = null
	var min_distance = INF
	
	for point in points_in_area:
		var distance = global_position.distance_to(point.global_position)
		if distance < min_distance:
			min_distance = distance
			closest = point
	
	time_to_think = min_distance
	return closest


func _on_navigation_agent_2d_navigation_finished() -> void:
	var think = time_to_think / 400 + randf_range(-1.4,0)
	if think < 0:
		think = 0.01
	print(think)
	$Timer.start(think)
