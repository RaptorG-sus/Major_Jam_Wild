extends Node2D


var attack_damage :float 
var knockback_force :float 
var stun_time :float


signal attack_end()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		
		var hitbox :HitboxComponent = area
		
		var attack = AttackData.new(attack_damage, knockback_force, stun_time)
		attack.attack_position = global_position

		hitbox.damage(attack)


func _on_animated_sprite_2d_animation_finished() -> void:
	attack_end.emit()
	queue_free()
