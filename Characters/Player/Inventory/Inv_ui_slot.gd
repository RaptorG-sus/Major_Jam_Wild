extends Panel


@onready var item_visual :Sprite2D = $Item_display
@onready var amount_text :Label = $Label

signal pressed(node :Panel)


# fonction qui met a jour l'AFFICHAGE
func update(slot :InvSlot) -> void:
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else: 
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = false
		if slot.amount > 1 :
			amount_text.visible = true
		amount_text.text = str(slot.amount)

func _on_button_pressed() -> void:
	pressed.emit(self)
