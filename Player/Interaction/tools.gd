extends Node2D

@onready var item :InvItem

signal attack_end()


func _ready() -> void:
	$Sprite2D.texture = item.texture


func _process(delta: float) -> void:
	print(global_position)
	rotation_degrees += 90 * delta * (1 / $Timer.wait_time )
	print(global_position)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		
		item.item_data.attack_position = global_position
		area.damage(item.item_data)

func _on_timer_timeout() -> void:
	attack_end.emit()
	queue_free()
