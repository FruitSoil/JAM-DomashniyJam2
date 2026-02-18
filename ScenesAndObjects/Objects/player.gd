extends CharacterBody2D

var Speed = 200.0
var money: int = 0
var hp = 3
var exit_around : bool = false
var Shitok_around : bool = false

func _ready() -> void:
	$"../CanvasLayer/Control/Radio/Label".text = "Money:" + str(money)
	$"../CanvasLayer/Shader".material.set("shader_parameter/aberration", 0.0)
	$"../CanvasLayer/Shader".material.set("shader_parameter/static_noise_intensity",  0.0) 

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	if direction and $Steps.playing == false:
		$Steps.play()
	if $"../CanvasLayer/Control/Radio/Terminal".radio == false:
		velocity = direction * Speed
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_released("Interact") and exit_around == true:
		get_tree().change_scene_to_file("res://ScenesAndObjects/Scenes/menu.tscn")

func add_money(count: int):
	money += count
	$PickUp.play()
	$"../CanvasLayer/Control/Radio/Label".text = "Money: " + str(money)

func damage():
	var twm = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	twm.tween_property($Sprite,"modulate",Color("29ff33"),0.4).from(Color(0.672, 0.0, 0.0, 1.0))
	hp -= 1
	$blood_fast.emitting = true
	$damage.emitting = true
	$blood_fast.rotation_degrees = randf_range(0,360)
	$Blood.emitting = true
	$"../CanvasLayer/Shader".material.set("shader_parameter/aberration", 0.03 * (3 -hp))
	$"../CanvasLayer/Shader".material.set("shader_parameter/static_noise_intensity", 0.05 * (3 -hp)) 
	if hp == 0:
		death()

func death():
	$"../Death_UI".visible = true
	Engine.time_scale = 0

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".visible = true
		$"../CanvasLayer/Help_label".text = "Press P to exit complex"
		exit_around = true

func _on_exit_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$"../CanvasLayer/Help_label".text = "Press P to exit complex"
		$"../CanvasLayer/Help_label".visible = false
		exit_around = false

func lights():
	$lights.play()
