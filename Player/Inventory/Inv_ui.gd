extends Control


@onready var inv :Inv = preload("res://Resource/Player_inventory.tres")
@onready var slots :Array = $NinePatchRect/GridContainer.get_children()

var is_open = false
var slot_from_index :int = -1


func _ready() -> void:
	inv.update.connect(update_slots)
	for s in slots:
		s.pressed.connect(drag_and_drop)
			
	update_slots()
	close()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()
	
	
func update_slots() -> void:
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
	
func open() -> void:
	visible = true
	is_open = true
	
func close() -> void:
	visible = false
	is_open = false
	
	
func drag_and_drop(inv_slot :Panel) -> void:
	var panel_index :int = int(str(inv_slot.name).get_slice("t", 1))
	
	if slot_from_index == -1:
		slot_from_index = panel_index -1
		return
	
	var slot_to_index = panel_index -1
	var temp_slot :InvSlot = inv.slots[slot_from_index]
	
	inv.slots[slot_from_index] = inv.slots[slot_to_index]
	inv.slots[slot_to_index] = temp_slot
	
	slot_from_index = -1

	update_slots()
