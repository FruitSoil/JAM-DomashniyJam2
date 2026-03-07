extends Node2D

var bullet = preload("res://ScenesAndObjects/Objects/bullet.tscn")
var see = false
var thinking: bool
var charging: bool = true
var side: int = 1
var numbe: Array = ["T",""]
var key: String = "turret"
var code_visible: bool = false
var hacked: bool = false

func _ready() -> void:
	number_roll()
	$Script.visible = false
	$Head/Hack_light.enabled = false

func _process(delta: float) -> void:
	if $Head/Ray.is_colliding() and $Head/Ray.get_collider().name == "Player" or $Head/Ray2.is_colliding() and $Head/Ray2.get_collider().name == "Player" or $Head/Ray3.is_colliding() and $Head/Ray3.get_collider().name == "Player":
		see = true
	elif thinking == false and hacked == false:
		thinking = true
		$player_in_zone_timer.start()
	
	if see:
		$Head/PointLight2D.enabled = true
		var direction_vector = $"../../Player".global_position - global_position
		var angle_in_radians = direction_vector.angle()
		$Head.rotation = lerp_angle($Head.rotation, angle_in_radians, 0.1)
	else:
		match side:
			1:
				$Head.rotation = lerp_angle($Head.rotation, -75, 0.01)
			2:
				$Head.rotation = lerp_angle($Head.rotation, 75, 0.01)

func _on_timer_timeout() -> void:
	if see and charging == false:
		%Camera.apply_powers(40,10)
		print("shoot by ", key, " turret")
		var inst = bullet.instantiate()
		$"..".add_child(inst)
		inst.global_position = $Head/Marker2D.global_position
		inst.rotation = $Head.rotation
		$shoot.play()
		var twe = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		twe.tween_property($Light, "energy", 0, 0.3).from(5)
	if see and charging == true and hacked == false:
		if Global.turret_hack and code_visible == false:
			$Script.visible = true
			var twm = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
			twm.tween_property($Script, "modulate", Color("ffffff"), 1.5).from(Color("ffffff00"))
		$shoot2.pitch_scale = 1.0
		if !$shoot2.playing:
			$shoot2.play()
		await get_tree().create_timer(1).timeout
		charging = false

func _on_player_in_zone_timer_timeout() -> void:
	see = false
	thinking = false
	charging = true
	$Head/PointLight2D.enabled = false
	await get_tree().create_timer(0.5).timeout
	if see == false:
		var twp = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		twp.tween_property($shoot2,"pitch_scale", 0.01, 0.5)
		await get_tree().create_timer(0.5).timeout
		$shoot2.playing = false

func _on_side_changer_timeout() -> void:
	if side == 1:
		side = 2
	else:
		side = 1

func number_roll():
	key = numbe.get(randi_range(0,1)) + str(randi_range(0,8)) + str(randi_range(0,8)) + str(randi_range(0,8)) + str(randi_range(0,8)) + str(randi_range(0,8))
	print("generated turret code: ",key)
	$Script/Panel/Code.text = key
	if $"../../CanvasLayer/Control/Radio/Terminal".keys.has(key) == false:
		$"../../CanvasLayer/Control/Radio/Terminal".keys.append(key)
	else:
		number_roll()

func object_action(given_key: String):
	if given_key == key:
		$Timer.stop()
		$Head/Hack_light.enabled = true
		hacked = true
		$Hack_sound.play()
		await get_tree().create_timer(10).timeout
		$Hack_sound.playing = false
		hacked = false
		$Timer.start()
		$Head/Hack_light.enabled = false
		$Head/Ray.enabled = true
		$Head/Ray2.enabled = true
		$Head/Ray3.enabled = true
