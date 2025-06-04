extends Resource

class_name Inv

signal update

@export var inv_slots :Array[InvSlot]
@export var equipment_slots :Array[InvSlot]
@export var active_slots :Array[InvSlot]


# fonction qui modifie la RESSOURCE (la seul avec drag and drop)
func insert(new_slot :InvSlot) -> void:
	
	var itemslots :Array[InvSlot] = inv_slots.filter(func(slot :InvSlot) -> bool: return slot.item == new_slot.item)
	if !itemslots.is_empty():
		# ici, tout les items des slots de l'array sont les mêmes que new_slot
		var i :int = 0
		var size :int = itemslots.size()
		# Boucle de remplissage des slots (slot.amount devient = slot.max_amount tant que les conditions sont remplit) 
		while ( (i < size) && (itemslots[i].amount + new_slot.amount > itemslots[i].max_amount) ):
			new_slot.amount -= (itemslots[i].max_amount - itemslots[i].amount)
			itemslots[i].amount = itemslots[i].max_amount
			i+=1
		# Si on a encore de la place dans un slot non vide (sortie car itemslots[i].amount + new_slot.amount <= new_slot.max_amount)
		if (i < size):
			itemslots[i].amount += new_slot.amount
		# Si on sort car on a remplit tout les slot de l'array (sortie car i >= size)
		elif new_slot.amount > 0:
			# on remplit un nouveau slot
			_cree_new_slot(new_slot)
		else:
			# ici, l'array est remplit et le new_slot est vide (amount = 0)
			pass
			
	else:
		_cree_new_slot(new_slot)
		
	update.emit()


func _cree_new_slot(new_slot :InvSlot) -> void:
	var emptyslots :Array[InvSlot] = inv_slots.filter(func(slot :InvSlot) -> bool: return slot.item == null)
	# ici, j'ai pas besoin de verifier le nombre amount car se suppose que tout les slots sont "bien formé" (amount <= max_amount)
	if !emptyslots.is_empty():
		emptyslots[0].item = new_slot.item
		emptyslots[0].amount = new_slot.amount
		emptyslots[0].max_amount = new_slot.max_amount
