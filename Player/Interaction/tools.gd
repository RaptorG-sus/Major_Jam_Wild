extends Node2D

@onready var item :InvItem

signal attack_end()

func _ready() -> void:
	$Sprite2D.texture = item.texture


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		
		var hitbox :HitboxComponent = area
		
		if item.item_data is AttackData:
			var attack :AttackData = item.item_data
			attack.attack_position = global_position

			hitbox.damage(attack)

func _on_timer_timeout() -> void:
	attack_end.emit()
	queue_free()
