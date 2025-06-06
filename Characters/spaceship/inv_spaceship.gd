extends Node2D

var inter_space : Control

func _on_button_pressed() -> void:
	get_tree().paused = false
	match SaveLoad.saveFileData.futurPlanet:
		"Planet002":
			$Planet1.hide()
			$Planet2.show()

	get_tree().change_scene_to_packed(PreloadData.screen_interPlanet)
