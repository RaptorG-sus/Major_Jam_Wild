extends Node


var to_destroy :Array[Node] = []


func _process(_delta: float) -> void:
	for node :Node in to_destroy:
		if is_instance_valid(node):
			node._apply_destruction()
	to_destroy.clear()


func append_queue(target :Node) -> void:
	if not to_destroy.has(target):
		to_destroy.append(target)
