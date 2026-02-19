extends Node2D

var bullet = preload("res://ScenesAndObjects/Objects/bullet.tscn")
var see = false
var thinking: bool
var charging: bool = true
var side: int = 1

func _process(delta: float) -> void:
	if $Head/Ray.is_colliding() and $Head/Ray.get_collider().name == "Player" or $Head/Ray2.is_colliding() and $Head/Ray2.get_collider().name == "Player" or $Head/Ray3.is_colliding() and $Head/Ray3.get_collider().name == "Player":
		see = true
	elif thinking == false:
		thinking = true
		$player_in_zone_timer.start()
	if see:
		$Head/PointLight2D.enabled = true
		var direction_vector = $"../../Player".global_position - global_position
		var angle_in_radians = direction_vector.angle()
		$Head.rotation = lerp_angle($Head.rotation, angle_in_radians, 0.04)
	else:
		match side:
			1:
				$Head.rotation = lerp_angle($Head.rotation, -75, 0.01)
			2:
				$Head.rotation = lerp_angle($Head.rotation, 75, 0.01)

func _on_timer_timeout() -> void:
	if see and charging == false:
		%Camera.apply_powers(60,10)
		print("sss")
		var inst = bullet.instantiate()
		$"..".add_child(inst)
		inst.global_position = $Head/Marker2D.global_position
		inst.rotation = $Head.rotation
		$Timer.wait_time = randf_range(0.27,0.33)
		$shoot.play()
		var twe = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		twe.tween_property($Light, "energy", 0, 0.3).from(1.5)
	if see and charging == true:
		$shoot2.play()
		await get_tree().create_timer(1).timeout
		charging = false

func _on_player_in_zone_timer_timeout() -> void:
	$shoot2.playing = false
	see = false
	thinking = false
	charging = true
	$Head/PointLight2D.enabled = false

func _on_side_changer_timeout() -> void:
	if side == 1:
		side = 2
	else:
		side = 1
