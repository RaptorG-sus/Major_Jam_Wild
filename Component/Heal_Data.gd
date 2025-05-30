extends ItemData
class_name HealData

@export var heal :int
@export var heal_time :int


func _init(_heal :int, _heal_time :int) -> void:
	heal = _heal
	heal_time = _heal_time
