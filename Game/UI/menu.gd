extends Control

var scene_principal = PreloadData.scene_principal
var debug_zone = PreloadData.debug_zone

func _on_debug_pressed() -> void:
	get_tree().change_scene_to_packed(debug_zone)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(scene_principal)