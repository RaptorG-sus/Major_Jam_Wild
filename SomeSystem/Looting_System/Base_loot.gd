extends Area2D


@onready var slot :InvSlot


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("collect"):
		body.collect(slot)
		PoolManager.free_node(self, 0)
