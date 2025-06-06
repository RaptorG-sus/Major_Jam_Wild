extends Node2D


func _on_texture_button_pressed() -> void:
	$"..".get_tree().paused = true
	$InvSpaceship.show()


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("partir"):
		$"..".get_tree().paused = false
		$InvSpaceship.hide()
