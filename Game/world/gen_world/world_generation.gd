extends Node2D

@onready var noise :FastNoiseLite = $Noise.texture.noise
@onready var map :TileMap = $TileMap
@onready var seed_world :int
@onready var seed_ore :int
var x_large : int

var tree_01 : PackedScene = PreloadData.tree_01
var tree_02 : PackedScene = PreloadData.tree_02
var tree_03 : PackedScene = PreloadData.tree_03
var tree_04 : PackedScene = PreloadData.tree_04

var all_tree :Array[PackedScene] = [tree_01,tree_02,tree_03,tree_04]

var all_chunk : Dictionary = SaveLoad.saveFileData.all_chunk

@export var planet_name : String = PlanetData.planet_name
@export var tileset : TileSet
@export var planetData : Dictionary = PlanetData.allPlanetData
var earth_value : float = -0.25                                                                     # pour plus ou moins de grotte / rocher volant
var ore_value : float = 0.3
var tree_percentage : int = 5                                                                       # pourcentage d'arbre permettant changeant en fonction de la planete

var range_generation : int = 4

func _ready() -> void:
	pass
	

func total_generation() -> void:
	noise = $Noise.texture.noise
	map = $TileMap
	tileset = load(planetData[planet_name]["TileSet"])
	map.set_tileset(tileset)
	terrain_generation()
	tree_generation()
	ore_generation()
	back_ground()
	

func terrain_generation() -> void:
	noise.seed = seed_world                                                                         # genere la seed du monde
	for x in range(range_generation):
		var ground :int = abs(noise.get_noise_2d(x_large + x,0)*10)  
		for y in range(ground, 128):   # genere les petites buttes de terre permettant un monde plus agréable ( * 10 pour des buttes plus abruptes)
			if noise.get_noise_2d(x_large + x,y) > earth_value:			   # genere en fonction du noise et aura plus ou moins de terre dependant de earthvalue
				map.set_cell(0, Vector2i(x,y), 0, Vector2i.ZERO, 1)     # pose les blocks
		

	
	
	  
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
		for y in range(30,128):                                                                 # generation en y
			if noise.get_noise_2d(x_large + x,y) > ore_value and map.get_cell_source_id(0,Vector2i(x,y)) == 0:                 # placement des minerais
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
		for i in range(y,128):
			map.set_cell(1,Vector2i(x,i),3,Vector2i.ZERO)



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	SaveLoad.saveFileData.all_chunk[str(map.global_position)] = []
	for cell in map.get_used_cells(0):
		SaveLoad.saveFileData.all_chunk[str(map.global_position)].append({
				"position": cell,
				"source_id": map.get_cell_source_id(0,cell),
			})
	for cell in map.get_used_cells(1):
		SaveLoad.saveFileData.all_chunk[str(map.global_position)].append({
				"position": cell,
				"source_id": map.get_cell_source_id(1,cell),
			})
	map.clear()
	print(map.global_position)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if str(map.global_position) in SaveLoad.saveFileData.all_chunk.keys():
		for cell : Dictionary in SaveLoad.saveFileData.all_chunk[str(map.global_position)]:
			if cell["source_id"]==3:
				map.set_cell(1,cell["position"],3,Vector2i.ZERO)
			else:
				map.set_cell(0,cell["position"],cell["source_id"],Vector2i.ZERO,1)
		SaveLoad.saveFileData.all_chunk.erase(str(map.global_position))
	else:
		total_generation()

	map.set_process(true)
	map.visible = true
