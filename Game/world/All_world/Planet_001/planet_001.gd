extends Node2D

var planet_load

func buildPlanet():
	if SaveLoad.saveFileData.planet001_status and !PlanetData.debug_planet:
		planet_load = SaveLoad.saveFileData.planet001_create
		$world_generation/TileMap.set_tileset(load(PlanetData.allPlanetData["Planet001"]["TileSet"]))
		for tile in planet_load:
			print(tile)
			$world_generation/TileMap.set_cell(0, tile["position"], tile["source_id"], Vector2i(0,0),1)
	else:
		print("test")
		$world_generation.planet_name = "Planet001"
		$world_generation.total_generation()
	
