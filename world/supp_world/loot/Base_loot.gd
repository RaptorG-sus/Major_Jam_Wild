extends Area2D
class_name Pickup


@export var item :InvItem


var player = null

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("collect"):
		player = body
		playercollect()
		await get_tree().create_timer(0.1).timeout
		queue_free()

func playercollect() -> void:
	player.collect(item)
