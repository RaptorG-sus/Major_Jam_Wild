extends Node2D

var number_ore : int
var roughness : int = 1


func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	if event.is_action_pressed("Interaction"):
		queue_free()
