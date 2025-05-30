extends Area2D
class_name HitboxComponent


@export var hp_comp :HealthComponent


func damage(attack :AttackData) -> void:
	if hp_comp:
		hp_comp.damage(attack)
