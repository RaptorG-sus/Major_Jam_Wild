extends Node

const ALL_POOL_SIZE := 50

var loot_scene := PreloadData.loot_preload
var loot_pool: Array[Node2D] = []

enum Node_Type{
	LOOT = 0
}


func _ready() -> void:
	for i in ALL_POOL_SIZE:
		var loot :Node2D = loot_scene.instantiate()
		_on_off(loot, 0, false)
		loot_pool.append(loot)
		add_child(loot)
		
func _witch_pool(node_type :Node_Type) -> Array:
	match node_type:
		0 : return loot_pool
		
	return []


func _witch_scene(node_type :Node_Type) -> PackedScene:
	match node_type:
		0 : return loot_scene
		
	return null


func _on_off(node: Node2D, node_type :Node_Type, state: bool) -> void:
	if node_type == 0:
		# node.get_type() = Area2D
		node.visible = state
		node.set_physics_process(state)
		node.set_deferred("monitoring", state)  # évite les erreurs moteur


func get_in_pool(node_type :Node_Type) -> Node2D:
	var pool :Array = _witch_pool(node_type)
	for node :Node2D in pool:
		if not node.visible:
			_on_off(node, node_type, true)
			return node
			
	# Si on veut augmenter la taille de la Pool
	var node :Node2D = _witch_scene(node_type).instantiate()
	add_child(node)
	_on_off(node, node_type, true)
	pool.append(node)
	return node
	
	
func free_node(node: Node2D, node_type :Node_Type):
	_on_off(node, node_type, false)
	node.global_position = Vector2.ZERO

	# reset position, item, etc. si besoin
