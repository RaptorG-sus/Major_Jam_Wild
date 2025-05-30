extends Control


@onready var inv :Inv = preload("res://Ressource/Player_inventory.tres")
@onready var inv_slots :Array = $Inventaire/GridContainer.get_children()
@onready var equipment_slots :Array = $Equipement/GridContainer.get_children()
@onready var active_slots :Array = $Action_bar/GridContainer.get_children()

var is_open = false
var slot_from :Panel = null
var slot_from_index :int = -1

signal update_player_stat(player_stat :ArmorData)
signal usable(slot :InvSlot)

func _ready() -> void:
	inv.update.connect(update_slots)
	for s in inv_slots:
		s.pressed.connect(slot_interaction)
	for s in equipment_slots:
		s.pressed.connect(slot_interaction)
	for s in active_slots:
		s.pressed.connect(slot_interaction)
		
	update_slots()
	close()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()
	
	
func update_slots() -> void:
	for i in range(min(inv.inv_slots.size(), inv_slots.size())):
		inv_slots[i].update(inv.inv_slots[i])
	for i in range(min(inv.equipment_slots.size(), equipment_slots.size())):
		equipment_slots[i].update(inv.equipment_slots[i])
	for i in range(min(inv.active_slots.size(), active_slots.size())):
		active_slots[i].update(inv.active_slots[i])
	

func open() -> void:
	is_open = true
	$Equipement.visible = true
	$Inventaire.visible = true
	get_tree().paused = true
	
	
func close() -> void:
	is_open = false
	$Equipement.visible = false
	$Inventaire.visible = false
	get_tree().paused = false

	
func parent_name(panel :Panel):
	var parent_name = panel.get_parent().get_parent().name
	match parent_name:
		"Inventaire" : return inv.inv_slots
		"Equipement" : return inv.equipment_slots
		"Action_bar" : return inv.active_slots
	
	
func slot_interaction(slot_to :Panel) -> void:
	if is_open:
		drag_and_drop(slot_to)
	else:
		var panel_index :int = int(str(slot_to.name).get_slice("t", 1))
		usable.emit(parent_name(slot_to)[panel_index -1])
	
	
func drag_and_drop(slot_to :Panel) -> void:
	var panel_index :int = int(str(slot_to.name).get_slice("t", 1))
	
	if slot_from == null && parent_name(slot_to)[panel_index-1].item == null:
		return

	if slot_from == null:
		slot_from = slot_to
		slot_from_index = panel_index -1
		return
		
	var slot_to_index = panel_index -1
	
	var inv_from :Array[InvSlot] = parent_name(slot_from)
	var inv_to :Array[InvSlot] = parent_name(slot_to)
	
	# Gère le moment ou on veut mettre un item dans un slot d'equipement
	if slot_to.get_parent().get_parent() == $Equipement:
		if !(inv_to[slot_to_index].item.type == 1) :
			slot_from = null
			slot_from_index = -1
			return
	
		update_player_stat.emit(inv_to[slot_to_index].item.stat)

	var temp_slot :InvSlot = inv_from[slot_from_index]
	inv_from[slot_from_index] = inv_to[slot_to_index]
	inv_to[slot_to_index] = temp_slot
	
	slot_from = null
	slot_from_index = -1

	update_slots()
