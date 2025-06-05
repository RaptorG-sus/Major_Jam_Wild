extends Node

const MAX_DESTRUCTION_PER_FRAME :int = 10

var to_destroy :Array[Node] = []


func _process(_delta: float) -> void:
	var count :int = 0

	while (!to_destroy.is_empty() && count < MAX_DESTRUCTION_PER_FRAME):
		if to_destroy[0] != null:
			var node :Node = to_destroy.pop_front()
			if is_instance_valid(node):
				node._apply_destruction()
			count += 1
		else :
			to_destroy.remove_at(0)

func append_queue(target :Node) -> void:
	if not to_destroy.has(target):
		to_destroy.append(target)
