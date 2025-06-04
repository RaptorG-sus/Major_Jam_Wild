extends Node2D

var planet_load :Dictionary
var seed_planet : int
var seed_ore : int

func _ready() -> void:
	print(get_tree())
	seed_planet = randi_range(1,65536)
	seed_ore = randi_range(1, 256)

func buildPlanet() -> void:
	if SaveLoad.saveFileData.planet001_status and !PlanetData.debug_planet:
		planet_load = SaveLoad.saveFileData.actual_planet
		seed_planet = SaveLoad.saveFileData.actual_planet["seed_planet"]
		seed_ore = SaveLoad.saveFileData.actual_planet["seed_ore"]
		SaveLoad.saveFileData.all_chunk = SaveLoad.saveFileData.actual_planet["chunk_unload"]
		for i in range(2000):
			var chunk_instance : Node2D = PreloadData.chunk.instantiate()
			var chunk_world : Node2D = chunk_instance.get_node("world_generation")
			chunk_world.get_node("TileMap").set_tileset(load(PlanetData.allPlanetData[PlanetData.planet_name]["TileSet"]))
			chunk_instance.global_position.x = 32*(-40+4*i)
			chunk_world.x_large = 4*i
			chunk_world.seed_world = seed_planet
			chunk_world.seed_ore = seed_ore
			if str(chunk_instance.global_position) in SaveLoad.saveFileData.actual_planet["chunk_load"].keys():
				for cell : Dictionary in SaveLoad.saveFileData.actual_planet["chunk_load"][str(chunk_instance.global_position)]:
					if cell["source_id"] == 3:
						chunk_world.get_node("TileMap").set_cell(1, cell["position"], cell["source_id"], Vector2i.ZERO)
					else:
						chunk_world.get_node("TileMap").set_cell(0, cell["position"], cell["source_id"], Vector2i.ZERO, 1)
			$all_chunk.add_child(chunk_instance)

		for tree :Dictionary in planet_load["tree"]:
			var tree_instance :Node2D = Node2D.new()
			var tilemap_instance :TileMap = TileMap.new()
			tilemap_instance.set_tileset(load(PlanetData.allPlanetData[PlanetData.planet_name]["TileSetTree"]))
			tree_instance.position = tree["position"]
			tilemap_instance.scale = Vector2i(2,2)
			for cell :Dictionary in tree["tile"]:
				tilemap_instance.set_cell(0,cell["position"], cell["source_id"], Vector2i(0,0), 1)
			$tree_gen_out_chunk.add_child(tree_instance)
			tree_instance.add_child(tilemap_instance)


	else:
		for i in range(2000):
			SaveLoad.saveFileData.planet_name = PlanetData.planet_name
			var chunk_instance :Node2D = PreloadData.chunk.instantiate()
			var chunk_world :Node2D = chunk_instance.get_node("world_generation")
			chunk_instance.global_position.x = 32*(-40+4*i)
			chunk_world.x_large = 4*i
			chunk_world.seed_world = seed_planet
			chunk_world.seed_ore = seed_ore
			chunk_world.get_node("TileMap").set_tileset(load(PlanetData.allPlanetData[PlanetData.planet_name]["TileSet"]))
			if i < 21: 
				chunk_world.total_generation()
			$all_chunk.add_child(chunk_instance)
			
