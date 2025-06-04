extends Control

var menu :PackedScene = PreloadData.menu

func _on_planet_001_pressed() -> void:
	PlanetData.planet_name = "Planet001"
	PlanetData.debug_planet = true   
	get_tree().change_scene_to_packed(PreloadData.scene_principal)
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(menu)
