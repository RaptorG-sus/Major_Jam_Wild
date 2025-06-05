extends ItemData
class_name ArmorData

@export var hp                   : int = 10
@export var armor                : int = 0
@export var speed                : float = 10
# Speed decay on ground (lowest = fastest response)
@export var ground_speed_decay   : float = 100
# Speed decay in air (lowest = fastest response)
@export var air_speed_decay      : float = 200
@export var jump_strength        : float = 300

func setup(_hp :int, _armor :int, _speed :float) -> void:
	hp = _hp
	armor = _armor
	speed = _speed
