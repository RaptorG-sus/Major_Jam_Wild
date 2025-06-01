extends Node

const MAX_DESTRUCTION_PER_FRAME :int = 10

var to_destroy :Array[Node] = []


func _process(_delta: float) -> void:
	var count :int = 0

	while (to_destroy.size() > 0 && count < MAX_DESTRUCTION_PER_FRAME):
		var node = to_destroy.pop_front()
		if is_instance_valid(node):
			node._apply_destruction()
		count += 1


func append_queue(target :Node) -> void:
	if not to_destroy.has(target):
		to_destroy.append(target)
