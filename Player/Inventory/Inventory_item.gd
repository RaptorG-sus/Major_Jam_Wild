extends Resource
class_name InvItem

enum Type{
	LOOT = 0,
	EQUIP = 1

}


@export var type :Type
@export var name :String = ""
@export var texture :Texture2D
