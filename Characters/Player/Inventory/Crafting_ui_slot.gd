extends Panel

@onready var requirement_scene :PackedScene = PreloadData.requirement_preload
@onready var item_visual :Sprite2D = $Crafting_Recipes/Item_display
@onready var amount_text :Label = $Crafting_Recipes/Label


signal pressed(node :Panel)


func initialisation_crafting_recipe(crafting_recipe :CraftingRecipe) -> void:
	if !crafting_recipe.slot || !crafting_recipe.requirement:
		item_visual.visible = false
		amount_text.visible = false
	else: 
		item_visual.visible = true
		
		var slot :InvSlot = crafting_recipe.slot
		item_visual.texture = slot.item.texture
		amount_text.visible = false
		if slot.amount > 1 :
			amount_text.visible = true
		amount_text.text = str(slot.amount)
		generation_requirement(crafting_recipe.requirement)


func generation_requirement(recipe_requirement :Array[InvSlot]) -> void:
	for slot in recipe_requirement:
		var requirement :Node = requirement_scene.instantiate()
		$VBoxContainer.add_child(requirement)
		requirement.initialisation_requirement(slot)



func _on_button_pressed() -> void:
	pressed.emit(self)
