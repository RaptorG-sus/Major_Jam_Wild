extends Control

var menu :PackedScene = PreloadData.menu

func _on_planet_001_pressed() -> void:
	PlanetData.planet_name = "Planet001"
	PlanetData.debug_planet = true
	SaveLoad.saveFileData.all_chunk = {}   
	get_tree().change_scene_to_packed(PreloadData.loading_screen)
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(menu)


func _on_planet_002_pressed() -> void:
	PlanetData.planet_name = "Planet002"
	PlanetData.debug_planet = true
	SaveLoad.saveFileData.all_chunk = {}      
	get_tree().change_scene_to_packed(PreloadData.loading_screen)
