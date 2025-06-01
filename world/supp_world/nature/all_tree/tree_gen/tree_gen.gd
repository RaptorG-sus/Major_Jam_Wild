extends Node2D
class_name block

var roughness : int = 1
var coord : Vector2i
@onready var map :Node2D = $".."


func _ready() -> void:
	$HitboxComponent.set_script(PreloadData.hitboxcomponent_preload)
	
	coord.x = position.x
	coord.y = position.y
	if coord.x < 0:
		coord.x -= 8 
	if coord.y < 0:
		coord.y -= 8
	coord.x = int(coord.x/32)
	coord.y = int(coord.y/32)

		
func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	if event.is_action_pressed("Interaction"):
		break_tree()
		#print(map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1)))


func break_tree() -> void:
	#drop item et particles
	while map.get_cell_source_id(0,coord) == 2:                
		map.erase_cell(0,coord)
		queue_free()
		coord.y -= 1


func _on_hitbox_component_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	var attack :AttackData = AttackData.new()
	attack.setup(1, 0, 0)
	attack.attack_position = global_position

	if event.is_action_pressed("Interaction"):
		print("test")
		$HitboxComponent.damage(attack)
