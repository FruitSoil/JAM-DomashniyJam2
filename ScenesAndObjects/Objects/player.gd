extends CharacterBody2D

var Speed = 200.0
var hp = 4
var exit_around : bool = false
var Shitok_around : bool = false
var current_money: int = 0
var scanner_coldown: float = 0

func _ready() -> void:
	$"../CanvasLayer/Control/Radio/Label".text = "I.N.K.: " + str(current_money) + "/300"
	$"../CanvasLayer/Shader".material.set("shader_parameter/aberration", 0.0)
	$"../CanvasLayer/Shader".material.set("shader_parameter/static_noise_intensity",  0.0) 
	$"../CanvasLayer/Control/Radio/Label".text = "I.N.K.: " + str(current_money) + "/300"
	if Global.cur_loc == "garden":
		$Ambient2.play()
		$Ambient.stop()

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction and $Steps.playing == false:
		$Steps.play()
	if $"../CanvasLayer/Control/Radio/Terminal".radio == false:
		velocity = direction * Speed
	else:
		velocity = Vector2(0,0)
	move_and_slide()

func _process(delta: float) -> void:
	scanner_coldown -= delta
	if Input.is_action_just_released("Interact") and exit_around == true and current_money >= 300:
		if Global.cur_loc != "guide":
			Global.money += current_money
		current_money = 0
		get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/menu.tscn")

func add_money(count: int):
	current_money += count
	$PickUp.play()
	$"../CanvasLayer/Quota".text = "Quota:\n" + str(current_money) + "/300"
	$"../CanvasLayer/Control/Radio/Label".text = "I.N.K.: " + str(current_money) + "/300"

func damage():
	var twm = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	hp -= 1
	%Camera.apply_powers(30,5)
	$damage.emitting = true
	$blood_fast.rotation_degrees = randf_range(0,360)
	if hp <= 3:
		$blood_fast.emitting = true
	if hp <= 2:
		$Blood.emitting = true
	if hp <= 1:
		twm.tween_property($"../Player_sprite","modulate",Color("b3544d"),0.7).from(Color(1.0, 1.0, 1.0, 1.0))
	else:
		twm.tween_property($"../Player_sprite","modulate",Color("29ff33"),0.7).from(Color(0.672, 0.0, 0.0, 1.0))
	$dmg.play()
	$dmg2.play()
	$"../CanvasLayer/Shader".material.set("shader_parameter/aberration", 0.02 * (3 -hp))
	$"../CanvasLayer/Shader".material.set("shader_parameter/static_noise_intensity", 0.02 * (3 -hp)) 
	if hp == 0:
		death()

func death():
	$"../Death_UI".visible = true
	Engine.time_scale = 0

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".visible = true
		if current_money >= 300:
			$"../CanvasLayer/Help_label".text = "Press P to exit complex"
		else:
			$"../CanvasLayer/Help_label".text = "You need to reach your QUOTA"
		exit_around = true
		$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("ff6f5d"))

func _on_exit_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".text = "Press P to exit complex"
		$"../CanvasLayer/Help_label".visible = false
		exit_around = false

func lights():
	$lights.play()


func _on_tutorial_body_entered(body: Node2D, value:int) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".visible = true
		match value:
			0:
				$"../CanvasLayer/Help_label".text = "Press LMB/TAB/Enter to toggle terminal"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("ffffffff"))
			1:
				$"../CanvasLayer/Help_label".text = "Open the terminal and enter the number from the floor"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("61db00ff"))
			2:
				$"../CanvasLayer/Help_label".text = "You can close the door by entering this code again"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("cd0bc6ff"))
			3:
				$"../CanvasLayer/Help_label".text = "Your task: collect loot, which is displayed in yellow"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("d0aa00ff"))
			4:
				$"../CanvasLayer/Help_label".text = "You can also turn on the lights in the complex by turning on the power panel"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("cd0bc6ff"))
			5:
				$"../CanvasLayer/Help_label".text = "There are various dangers in the location, be careful!"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("b20000ff"))
			6:
				$"../CanvasLayer/Help_label".text = "To leave the location you need to reach the quota, look for loot"
				$"../CanvasLayer/Help_label".add_theme_color_override("font_color",Color("d0aa00ff"))

func _on_tutorial_body_exited(body: Node2D, value:int) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".visible = false
		match value:
			0:
				$"../CanvasLayer/Help_label".text = "Press LMB to toggle terminal"
			1:
				$"../CanvasLayer/Help_label".text = "Open the terminal and enter the number from the floor."

func toggle_flash():
	$flashlight/lights.play()
	if $flashlight/Light.enabled:
		$flashlight/Light.enabled = false
	else:
		$flashlight/Light.enabled = true

func scanner():
	$scanner/scanner/CollisionShape2D.disabled = false
	scanner_coldown = 10.0
	await get_tree().create_timer(2).timeout
	$scanner/scanner/CollisionShape2D.disabled = true

func music_toggle():
	$"../CanvasLayer/Control/Radio/terminal2".play()
	if $Music.playing:
		print("stop")
		$Music.stream_paused = true
		AudioServer.set_bus_effect_enabled(3,1,false)
		AudioServer.set_bus_effect_enabled(4,1,false)
	elif $Music.stream_paused:
		print("stop end ")
		$Music.stream_paused = false
		AudioServer.set_bus_effect_enabled(3,1,true)
		AudioServer.set_bus_effect_enabled(4,1,true)
	if $Music.playing == false and $Music.stream_paused == false:
		$Music.stream_paused = false
		$Music.play()
		AudioServer.set_bus_effect_enabled(3,1,true)
		AudioServer.set_bus_effect_enabled(4,1,true)
		print("play")
