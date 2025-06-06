extends Control

func _ready() -> void:
	$TextureButton2.disabled = true
	$TextureButton3.disabled = true
	$TextureButton4.disabled = true
	$TextureButton5.disabled = true
	if SaveLoad.saveFileData.planet002_status:
		$TextureButton2/Panel.hide()
		$TextureButton2.disabled = false
	if SaveLoad.saveFileData.planet003_status:
		$TextureButton3/Panel.hide()
		$TextureButton3.disabled = false
	if SaveLoad.saveFileData.planet004_status:
		$TextureButton4/Panel.hide()
		$TextureButton4.disabled = false
	if SaveLoad.saveFileData.planet005_status:
		$TextureButton5/Panel.hide()
		$TextureButton5.disabled = false

func _on_texture_button_pressed() -> void:
	PlanetData.planet_name = "Planet001"
	get_tree().change_scene_to_packed(PreloadData.loading_screen)


func _on_texture_button_5_pressed() -> void:
	PlanetData.planet_name = "Planet005"
	get_tree().change_scene_to_packed(PreloadData.loading_screen)


func _on_texture_button_4_pressed() -> void:
	PlanetData.planet_name = "Planet004"
	get_tree().change_scene_to_packed(PreloadData.loading_screen)


func _on_texture_button_3_pressed() -> void:
	PlanetData.planet_name = "Planet003"
	get_tree().change_scene_to_packed(PreloadData.loading_screen)


func _on_texture_button_2_pressed() -> void:
	print("bobo")
	PlanetData.planet_name = "Planet002"
	get_tree().change_scene_to_packed(PreloadData.loading_screen)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(PreloadData.loading_screen)
