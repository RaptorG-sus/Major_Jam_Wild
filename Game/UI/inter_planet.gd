extends Control

func _ready() -> void:
    if SaveLoad.saveFileData.planet002_status:
        $TextureButton2.Panel.hide()
    if SaveLoad.saveFileData.planet003_status:
        $TextureButton3.Panel.hide()
    if SaveLoad.saveFileData.planet004_status:
        $TextureButton4.Panel.hide()
    if SaveLoad.saveFileData.planet005_status:
        $TextureButton5.Panel.hide()

func _on_texture_button_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_5_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_4_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_2_pressed() -> void:
	pass # Replace with function body.
