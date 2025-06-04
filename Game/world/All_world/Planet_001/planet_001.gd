extends Node2D

var planet_load :Dictionary
var seed_planet : int
var seed_ore : int

func _ready() -> void:
	seed_planet = randi_range(1,65536)
	seed_ore = randi_range(1, 256)

func buildPlanet() -> void:
	if SaveLoad.saveFileData.planet001_status and !PlanetData.debug_planet:
		planet_load = SaveLoad.saveFileData.planet001_create
		$world_generation/TileMap.set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSet"]))
		for tile :Dictionary in planet_load["Tile"]:
			if tile["source_id"] == 3:
				$world_generation/TileMap.set_cell(1, tile["position"], tile["source_id"], Vector2i(0,0))
			else:
				$world_generation/TileMap.set_cell(0, tile["position"], tile["source_id"], Vector2i(0,0),1)
		
		
		for tree :Dictionary in planet_load["Tree"]:
			var tree_instance :Node2D = Node2D.new()
			var tilemap_instance :TileMap = TileMap.new()
			tilemap_instance.set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSetTree"]))
			tree_instance.position = tree["position"]
			tilemap_instance.scale = Vector2i(2,2)
			for cell :Dictionary in tree["tile"]:
				tilemap_instance.set_cell(0,cell["position"], cell["source_id"], Vector2i(0,0), 1)
			$world_generation/tree_gen.add_child(tree_instance)
			tree_instance.add_child(tilemap_instance)
	else:
		for i in range(3):
			var chunk_instance :Node2D = PreloadData.chunk.instantiate()
			var chunk_world :Node2D = chunk_instance.get_node("world_generation")
			chunk_instance.global_position.x = 32*(-24+16*i)
			chunk_world.planet_name = "Planet_001"
			chunk_world.x_large = -24 + 16*i
			chunk_world.seed_world = seed_planet
			chunk_world.seed_ore = seed_ore
			chunk_world.get_node("TileMap").set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSet"])) 
			chunk_world.total_generation()
			add_child(chunk_instance)
			
