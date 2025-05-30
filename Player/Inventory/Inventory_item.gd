extends Resource
class_name InvItem

enum Type{
	LOOT = 0,
	EQUIP = 1

}


@export var type :Type
@export var name :String = ""
@export var texture :Texture2D

var stat :Player_stat = Player_stat.new()

@export var hp :int
@export var armor :int
@export var speed :float


func _ready() -> void:
	if type == 1:
		stat.hp = hp
		stat.armor = armor
		stat.speed = speed
