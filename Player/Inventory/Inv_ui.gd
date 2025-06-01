extends Control


@onready var inv :Inv = PreloadData.inventory_preload
@onready var inv_slots :Array = %Inventaire/GridContainer.get_children()
@onready var equipment_slots :Array = %Equipement/GridContainer.get_children()
@onready var active_slots :Array = %Action_bar/GridContainer.get_children()

var panel_from :Panel = null
var slot_from_index :int = -1

signal update_player_stat(player_stat :ArmorData)
signal usable(slot :InvSlot)

func _ready() -> void:
	inv.update.connect(update_array_slots)
	for inv_ui_slot :Panel in inv_slots:
		inv_ui_slot.pressed.connect(slot_interaction)
	for inv_ui_slot :Panel in equipment_slots:
		inv_ui_slot.pressed.connect(slot_interaction)
	for inv_ui_slot :Panel in active_slots:
		inv_ui_slot.pressed.connect(slot_interaction)
		
	update_array_slots()
	update_array_slots(inv.equipment_slots, equipment_slots)
	update_array_slots(inv.active_slots, active_slots)


# J'ai mis ces valeur de base pour le insert de inv, qui lui fonctionne que dans le inv_slots
func update_array_slots(inv_array :Array[InvSlot] = inv.inv_slots, node_array :Array[Node] = inv_slots) -> void:
	for i in range(min(inv_array.size(), node_array.size())):
		node_array[i].update(inv_array[i])

	
func parent_name(panel :Panel) -> Array[InvSlot]:
	var parent_name :String = panel.get_parent().get_parent().name
	match parent_name:
		"Inventaire" : return inv.inv_slots
		"Equipement" : return inv.equipment_slots
		"Action_bar" : return inv.active_slots
	return []
	
func slot_interaction(slot :Panel) -> void:
	if $GlobalInventory.is_open:
		_drag_and_drop(slot)
	else:
		var panel_index :int = int(str(slot.name).get_slice("t", 1))
		usable.emit(parent_name(slot)[panel_index -1])
	
	
func _drag_and_drop(panel_to :Panel) -> void:
	var panel_index :int = int(str(panel_to.name).get_slice("t", 1))
	
	if panel_from == null && parent_name(panel_to)[panel_index-1].item == null:
		return

	if panel_from == null:
		panel_from = panel_to
		slot_from_index = panel_index -1
		return
		
	var slot_to_index :int = panel_index -1
	
	var inv_from :Array[InvSlot] = parent_name(panel_from)
	var inv_to :Array[InvSlot] = parent_name(panel_to)

	
	# Gère le moment ou on veut mettre un item dans un slot d'equipement
	if panel_to.get_parent().get_parent() == %Equipement:
		if !(inv_from[slot_from_index].item.item_data is ArmorData) :
			panel_from = null
			slot_from_index = -1
			return
	
		update_player_stat.emit(inv_to[slot_to_index].item.stat)

	if (inv_from[slot_from_index].item == inv_to[slot_to_index].item):
		inv_to[slot_to_index].amount += inv_from[slot_from_index].amount
		inv_from[slot_from_index].amount = 0
		inv_from[slot_from_index].item = null
		
	else:
		var temp_slot :InvSlot = inv_from[slot_from_index]
		inv_from[slot_from_index] = inv_to[slot_to_index]
		inv_to[slot_to_index] = temp_slot

	panel_from = null
	slot_from_index = -1
	
	update_array_slots()
	update_array_slots(inv.equipment_slots, equipment_slots)
	update_array_slots(inv.active_slots, active_slots)
