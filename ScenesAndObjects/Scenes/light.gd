extends PointLight2D


func switch_light():
	if visible:
		visible = false
	else:
		visible = true
