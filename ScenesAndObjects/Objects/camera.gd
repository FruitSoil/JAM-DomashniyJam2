extends Camera2D

var cam_scale := 0.5
var shake_pwr = 0
var shake_stbl = 0
var aiming := false

func _physics_process(delta: float) -> void:
	#Shake
	if shake_pwr > 0:
		offset.x = randi_range(-1,1) * shake_pwr
		offset.y = randi_range(-1,1) * shake_pwr
	shake_pwr -= shake_stbl 
	if shake_pwr < 0:
		shake_pwr = 0

func apply_powers(streight: float, fade_speed: float):
	shake_pwr = streight
	shake_stbl = fade_speed
