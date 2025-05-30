extends ItemData
class_name HealData

@export var heal :int
@export var heal_time :float


func _init(_heal :int, _heal_time :float) -> void:
	heal = _heal
	heal_time = _heal_time
