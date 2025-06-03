extends Node2D

var planet_load

func buildPlanet():
	if SaveLoad.saveFileData.planet001_status and !PlanetData.debug_planet:
		planet_load = SaveLoad.saveFileData.planet001_create
		$world_generation/TileMap.set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSet"]))
		for tile in planet_load["Tile"]:
			if tile["source_id"] == 3:
				$world_generation/TileMap.set_cell(1, tile["position"], tile["source_id"], Vector2i(0,0))
			else:
				$world_generation/TileMap.set_cell(0, tile["position"], tile["source_id"], Vector2i(0,0),1)
		
		
		for tree in planet_load["Tree"]:
			var tree_instance = Node2D.new()
			var tilemap_instance = TileMap.new()
			tilemap_instance.set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSetTree"]))
			tree_instance.position = tree["position"]
			tilemap_instance.scale = Vector2i(2,2)
			for cell in tree["tile"]:
				print(cell)
				tilemap_instance.set_cell(0,cell["position"], cell["source_id"], Vector2i(0,0), 1)
			$world_generation/tree_gen.add_child(tree_instance)
			tree_instance.add_child(tilemap_instance)
	else:
		print("test")
		$world_generation.planet_name = "Planet001"
		$world_generation.total_generation()
	
