extends Area2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.add_money(50)
		
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "scanner":
		$Sprite.material.set_light_mode(1)
		print("loot_scanned")
		await get_tree().create_timer(randf_range(0,0.2)).timeout
		$Scan_sound.play()

func _on_area_exited(area: Area2D) -> void:
	$Sprite.material.set_light_mode(2)
	print("loot_unscanned")
