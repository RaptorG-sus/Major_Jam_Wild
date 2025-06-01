extends Resource

class_name Inv

signal update

@export var inv_slots :Array[InvSlot]
@export var equipment_slots :Array[InvSlot]
@export var active_slots :Array[InvSlot]


func insert(new_slot :InvSlot) -> void:
	
	var itemslots :Array[InvSlot] = inv_slots.filter(func(slot :InvSlot) -> bool: return slot.item == new_slot.item)
	if !itemslots.is_empty():
		itemslots[0].amount += new_slot.amount
	else:
		var emptyslots :Array[InvSlot] = inv_slots.filter(func(slot :InvSlot) -> bool: return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = new_slot.item
			emptyslots[0].amount = new_slot.amount
	update.emit()
