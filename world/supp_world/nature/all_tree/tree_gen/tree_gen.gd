extends Node2D
class_name block

var roughness : int = 1
var coord : Vector2i
@onready var map = $".."

func _ready():
	coord.x = position.x
	coord.y = position.y
	if coord.x < 0:
		coord.x -= 8 
	if coord.y < 0:
		coord.y -= 8
	coord.x = int(coord.x/16)
	coord.y = int(coord.y/16)


func _process(delta):
	await (get_tree().create_timer(0.2)).timeout
	if (map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1))) != 0 and (map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1))) != 2:
		break_tree()
		#print(map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1)))


func break_tree():
	#drop item et particles
	print(coord)
	map.erase_cell(0,coord)
	queue_free()


func _on_hitbox_component_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	var attack = Attack.new()
	attack.attack_damage = 1
	attack.knockback_force = 0
	attack.attack_position = global_position
	attack.stun_time = 0
	if event.is_action_pressed("Interaction"):
		print("test")
		$HitboxComponent.damage(attack)
