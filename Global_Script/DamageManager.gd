extends Node

var queue :Array[Array] = []


func _process(_delta: float) -> void:
	for pair :Array in queue:
		var target :Node = pair[0]
		var attack :AttackData = pair[1]
		if is_instance_valid(target):
			target._apply_damage(attack)  # appel différé / léger
	queue.clear()


func append_queue(target :Node, attack :AttackData) -> void:
	if not queue.has([target, attack]):
		queue.append([target, attack])
