extends Control

@onready var inv :Inv = PreloadData.inventory_preload
@onready var inv_slots :Array[InvSlot] = inv.inv_slots
@onready var equipment_slots :Array[InvSlot] = inv.equipment_slots
@onready var active_slots :Array[InvSlot] = inv.active_slots

@onready var object_panel :Panel = $ObjectPanel
@onready var crafting_panel :Panel = $CraftingPanel
@onready var vboxcontainer :VBoxContainer = $VBoxContainer

@onready var all_recepies :ArrayCraftingRecipes = PreloadData.recipes_preload
@onready var all_panel_recipies :Array[Panel]


var is_open :bool = false


func _ready() -> void:
	
	
	object_panel.visible = false
	crafting_panel.visible = false
	$VBoxContainer.visible = false
	
	for page in $CraftingPanel/Craft.get_children():
		for crafting_ui_slot in page.get_children():
			crafting_ui_slot.pressed.connect(craft_process)
			all_panel_recipies.append(crafting_ui_slot)

	initialisation_crafting_recipes(all_recepies.array_crafting_recipes, all_panel_recipies)

func initialisation_crafting_recipes(array_crafting_recipes :Array[CraftingRecipe], array_node_recipes :Array[Panel]) -> void:
	for i in range(min(array_crafting_recipes.size(), array_node_recipes.size())):
		array_node_recipes[i].initialisation_crafting_recipe(array_crafting_recipes[i])


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			_close()
		else:
			_open()


func _open() -> void:
	is_open = true
	object_panel.visible = true
	crafting_panel.visible = false
	$VBoxContainer.visible = true
	
	$VBoxContainer/ObjectPanelButton.mouse_filter = Control.MOUSE_FILTER_STOP

	get_tree().paused = true
	
	
func _close() -> void:
	get_tree().paused = false
	
	is_open = false
	object_panel.visible = false
	crafting_panel.visible = false
	$VBoxContainer.visible = false

	


func _on_object_panel_button_pressed() -> void:
	object_panel.mouse_filter =  Control.MOUSE_FILTER_STOP
	crafting_panel.visible = false
	$VBoxContainer/ObjectPanelButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$VBoxContainer/CraftingPanelButton.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_crafting_panel_button_pressed() -> void:
	if !crafting_panel.visible:
		object_panel.mouse_filter =  Control.MOUSE_FILTER_IGNORE
		crafting_panel.visible = true
		$VBoxContainer/ObjectPanelButton.mouse_filter = Control.MOUSE_FILTER_STOP
		$VBoxContainer/CraftingPanelButton.mouse_filter = Control.MOUSE_FILTER_IGNORE


func craft_process(panel :Panel) -> void:
	var panel_index :int = panel.get_index(false)
	var recipe : CraftingRecipe = all_recepies.array_crafting_recipes[panel_index]
	
	for slot in recipe.requirement:
		if  !_having_requirement(slot):
			return
	inv.insert(recipe.slot)
	
	var parent :Control = self.get_parent()
	parent.update_array_slots()
	parent.update_array_slots(inv.equipment_slots, %Equipement/GridContainer.get_children())
	parent.update_array_slots(inv.active_slots, %Active_bar/GridContainer.get_children())

func _having_requirement(slot_need :InvSlot) -> bool:

	# Récuperation de tout les Slots qui ont le même item 
	var array_inv_slots :Array[InvSlot] = inv_slots.filter(func(slot :InvSlot) -> bool: return slot.item == slot_need.item)
	var array_equipment_slot :Array[InvSlot] = equipment_slots.filter(func(slot :InvSlot) -> bool: return slot.item == slot_need.item)
	var array_active_slot :Array[InvSlot] = active_slots.filter(func(slot :InvSlot) -> bool: return slot.item == slot_need.item)
	
	# Verification si on a au moins une fois l'item demandé dans l'invenaire global
	if array_inv_slots.is_empty() && array_equipment_slot.is_empty() && array_active_slot.is_empty() :
		return false
	# Verification qu'on a au moins le nombre necessaire
	var amount_need :int = slot_need.amount
	var sum :int = 0
	
	for slot :InvSlot in array_inv_slots:
		sum += slot.amount
	for slot :InvSlot in array_equipment_slot:
		sum += slot.amount
	for slot :InvSlot in array_active_slot:
		sum += slot.amount
		
	if sum < amount_need:
		return false
	
	var slot_index
	
	# Suppression des items dans l'inventaires
	for slot in array_inv_slots:
		
		slot_index = inv_slots.find(slot)
		if inv_slots[slot_index].amount > amount_need:
			inv_slots[slot_index].amount -= amount_need
			return true
		else:
			amount_need -= inv_slots[slot_index].amount
			inv_slots[slot_index].amount = 0
			inv_slots[slot_index].item = null
			
	for slot in array_equipment_slot:
		slot_index = equipment_slots.find(slot)
		if equipment_slots[slot_index].amount > amount_need:
			equipment_slots[slot_index].amount -= amount_need
			return true
		else:
			amount_need -= equipment_slots[slot_index].amount
			equipment_slots[slot_index].amount = 0
			equipment_slots[slot_index].item = null

	for slot in array_active_slot:
		slot_index = active_slots.find(slot)
		if active_slots[slot_index].amount > amount_need:
			active_slots[slot_index].amount -= amount_need
			return true
		else:
			amount_need -= active_slots[slot_index].amount
			active_slots[slot_index].amount = 0
			active_slots[slot_index].item = null
		
	return true
	
	
	
