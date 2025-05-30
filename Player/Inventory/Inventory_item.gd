extends Resource
class_name InvItem

enum Type {
	LOOT = 0,
	ARMURE = 1,
	ARME = 2,
	HEAL = 3
}

@export var type :Type = Type.LOOT
@export var name :String = ""
@export var texture :Texture2D 

@export var item_data :ItemData
