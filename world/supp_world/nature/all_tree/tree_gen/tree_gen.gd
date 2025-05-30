extends Node2D

var roughness : int = 1
var coord : Vector2i
@onready var map = $".."

func _ready():
	coord.x = int(position.x/16)
	coord.y = int(position.y/16)

func _process(delta):
	if (map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1))) != 4 and (map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1))) != 1:
		print(map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1)))

func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	print(map.get_cell_source_id(0,Vector2i(coord.x,coord.y+1)))
	if event.is_action_pressed("Interaction"):
		break_tree()


func break_tree():
	#drop item et particles
	queue_free()
