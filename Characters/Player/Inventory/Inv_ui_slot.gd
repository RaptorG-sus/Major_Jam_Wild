extends Panel


@onready var item_display :Sprite2D = $Item_display
@onready var panel :Panel = $Panel
@onready var label :Label = $Panel/Label

signal pressed(node :Panel)


# fonction qui met a jour l'AFFICHAGE
func update(slot :InvSlot) -> void:
	if !slot.item:
		item_display.visible = false
		panel.visible = false
	else: 
		item_display.visible = true
		item_display.texture = slot.item.texture
		panel.visible = false
		if slot.amount > 1 :
			panel.visible = true
		label.text = str(slot.amount)

func _on_button_pressed() -> void:
	pressed.emit(self)
