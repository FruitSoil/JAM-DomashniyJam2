extends Node2D

var loot = preload("res://ScenesAndObjects/Objects/loot.tscn")
var loot_count = 15

func _ready() -> void:
	var points = $".".get_child_count() -1
	if points >= loot_count:
		for i in loot_count:
			var inst = loot.instantiate()
			var child = $".".get_child(randi_range(0,points))
			$".".add_child(inst)
			inst.global_position = child.global_position

func _process(delta: float) -> void:
	pass
