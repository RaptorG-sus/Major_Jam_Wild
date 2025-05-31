extends ItemData
class_name AttackData

@export var attack_damage :float
@export var knockback_force :float
@export var attack_position :Vector2
@export var stun_time :float


func setup(_attack_damage :float, _knockback_force :float, _stun_time :float ) -> void:
	attack_damage = _attack_damage
	knockback_force = _knockback_force
	stun_time = _stun_time
