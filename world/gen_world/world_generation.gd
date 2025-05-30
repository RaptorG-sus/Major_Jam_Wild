extends Node2D

@onready var noise = $Noise.texture.noise
@onready var map = $TileMap

func _ready() -> void:

	var block = Vector2i(3,2)
	for x in range(100):
		for y in range(100):
			if noise.get_noise_2d(x,y) > 0 :
				map.set_cell(0,Vector2i(x,y),1,block)   
