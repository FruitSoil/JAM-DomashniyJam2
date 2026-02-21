extends PointLight2D

var visibled = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if global_position.distance_to($"../../Player".global_position) > (scale.x * texture_scale * texture.get_width()) /1.7:
		visible = false
	else:
		visible = visibled

func switch_light():
	if visibled:
		visibled = false
	else:
		visibled = true
