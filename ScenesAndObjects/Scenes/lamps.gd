extends TileMapLayer


func _ready() -> void:
	visible = true

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	visible = false
	await get_tree().create_timer(randf_range(0.1,5.9)).timeout
	visible = true
