extends Node2D

@onready var noise :FastNoiseLite = $Noise.texture.noise
@onready var map :TileMap = $TileMap
@onready var seed_world :int = randi_range(1, 65536)
@onready var seed_ore :int = randi_range(1,256)

var tree_01 : PackedScene = PreloadData.tree_01
var tree_02 : PackedScene = PreloadData.tree_02
var tree_03 : PackedScene = PreloadData.tree_03
var tree_04 : PackedScene = PreloadData.tree_04

var all_tree = [tree_01,tree_02,tree_03,tree_04]

@export var planet_name : String
@export var tileset : TileSet
@export var planetData : Dictionary = PlanetData.allPlanetData
var earth_value : float = -0.25                                                                     # pour plus ou moins de grotte / rocher volant
var ore_value : float = 0.3
var tree_percentage : int = 5                                                                       # pourcentage d'arbre permettant changeant en fonction de la planete

var range_generation : int = 200

func _ready() -> void:
	pass
	

func total_generation():
	noise = $Noise.texture.noise
	map = $TileMap
	seed_world = randi_range(1, 65536)
	seed_ore = randi_range(1,256)
	tileset = load(planetData["Planet001"]["TileSet"])
	map.set_tileset(tileset)
	call_deferred("terrain_generation")
	call_deferred("tree_generation")
	call_deferred("ore_generation")
	call_deferred("back_ground")

func terrain_generation() -> void:
	noise.seed = seed_world                                                                         # genere la seed du monde
	for x in range(range_generation):
		var ground :int = abs(noise.get_noise_2d(x,0)*10)  
		for y in range(ground, 500):   # genere les petites buttes de terre permettant un monde plus agréable ( * 10 pour des buttes plus abruptes)
			if noise.get_noise_2d(x,y) > earth_value:			   # genere en fonction du noise et aura plus ou moins de terre dependant de earthvalue
				map.set_cell(0, Vector2i(x,y), 0, Vector2i(0,0), 1)     # pose les blocks
	
		

	
	
	  
func tree_generation() -> void:
	if tree_percentage > 0:                                                                         # verification initial pour éviter des faires des boucles infini si aucun arbre voulue
		for x in range(range_generation):
			if randi()%100 < tree_percentage:                                                       # pourcentage pour avoir l'arbre
				var y :int = 0
				while map.get_cell_source_id(0,Vector2i(x,y)) != 0:                          # pour poser le block au plus bas possible jusqu'a la hauteur voulue (suite du while)
					y+=1
				var temp : int = randi_range(0,len(all_tree)-1)
				var tree : Node2D = all_tree[temp].instantiate()
				tree.path = all_tree[temp]
				$tree_gen.add_child(tree)
				tree.position = Vector2i(x*32,(y-10)*32)
				for i in range(10):
					tree.get_node("TileMap").set_cell(0,Vector2i(0,i),0,Vector2i(0,0),1)                            # à remplacer par "load_scene_arbre(coord x, y patati patata)

func ore_generation() -> void:
	noise.seed = seed_ore                                                                           # genere prend une nouvelle seed pour les minerais
	for x in range(range_generation):                   
											  # adoucir les minerais
		for y in range(75,500):                                                                 # generation en y
			if noise.get_noise_2d(x,y) > ore_value and map.get_cell_source_id(0,Vector2i(x,y)) == 0:                 # placement des minerais
				map.erase_cell(0,Vector2i(x,y))
				map.set_cell(0,Vector2i(x,y),1,Vector2i.ZERO,1)

func back_ground() -> void:
	noise.seed = seed_world
	for x in range(range_generation):
		var y :int = 0
		var flag_background :bool = true
		while flag_background:
			if map.get_cell_source_id(0,Vector2i(x,y)) == 0:
				flag_background = false
			else:
				y += 1
		for i in range(y,500):
			map.set_cell(1,Vector2i(x,i),3,Vector2i.ZERO)

"""func _input(event):
	if event.is_action_pressed("save"):
		print("save ?")
		SaveLoad.saveFileData.player_position = $Player.global_position
		SaveLoad.save_data()"""
		
