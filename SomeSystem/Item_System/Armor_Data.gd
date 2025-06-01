extends ItemData
class_name ArmorData

@export var hp :int
@export var armor :int
@export var speed :float

func setup(_hp :int, _armor :int, _speed :float) -> void:
	hp = _hp
	armor = _armor
	speed = _speed
