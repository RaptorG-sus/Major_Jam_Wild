extends Control

var scene_principal :PackedScene = PreloadData.scene_principal
var debug_zone :PackedScene = PreloadData.debug_zone

func _on_debug_pressed() -> void:
	get_tree().change_scene_to_packed(debug_zone)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_start_pressed() -> void:
	if SaveLoad.saveFileData.planet_name != "":
		PlanetData.planet_name = SaveLoad.saveFileData.planet_name
	PlanetData.debug_planet = false
	get_tree().change_scene_to_packed(scene_principal)
