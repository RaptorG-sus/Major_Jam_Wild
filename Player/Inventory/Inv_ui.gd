extends Control


@onready var inv :Inv = preload("res://Resource/Player_inventory.tres")
@onready var inv_slots :Array = $Inventaire/GridContainer.get_children()
@onready var equipment_slots :Array = $Equipement/GridContainer.get_children()
@onready var active_slots :Array = $Action_bar.get_children()

var is_open = false
var slot_from :Panel = null

signal update_player_stat(player_stat :Player_stat)


func _ready() -> void:
	inv.update.connect(update_slots)
	
	for s in inv_slots:
		s.pressed.connect(drag_and_drop)
	for s in equipment_slots:
		s.pressed.connect(drag_and_drop)
	for s in active_slots:
		s.pressed.connect(drag_and_drop)
		
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

	
	
func drag_and_drop(slot :Panel) -> void:
	
	if slot_from == null:
		slot_from = slot
		return
		
	var temp_slot :Panel = slot_from
	
	# Gère le moment ou on veut mettre un item dans un slot d'equipement
	if slot.get_parent().get_parent() == $Equipement:
		if !(slot_from.item.type == 1) :
			slot_from = null
			return
	
		update_player_stat.emit(slot_from.stat)
		
	slot_from = slot
	slot = temp_slot
	
	slot_from = null

	update_slots()
