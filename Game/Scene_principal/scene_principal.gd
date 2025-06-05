extends Node2D

@export var play_scene : Array             # Transmis par des boutons lors de la CREATION de la planet (non pas le chargement)
var planet_instance :Node
var planet_name :String


func _ready() -> void:
	SaveLoad.load_data()
	print(PlanetData.planet_name, "baba")
	var planet :PackedScene = PlanetData.allPlanetData[PlanetData.planet_name]["Scene"]
	planet_instance = planet.instantiate()
	add_child(planet_instance)
	planet_instance.buildPlanet()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		print("save dans le scene principal")
		SaveLoad.saveFileData.planet001_status = true
		_save_planet()
		SaveLoad.save_data()

func _save_planet() -> void:
	SaveLoad.saveFileData.actual_planet = {}
	planet_name = PlanetData.planet_name
	SaveLoad.saveFileData.actual_planet["chunk_unload"] = SaveLoad.saveFileData.all_chunk
	SaveLoad.saveFileData.actual_planet["chunk_load"] = {}
	SaveLoad.saveFileData.actual_planet["tree"] = []
	for chunk in planet_instance.get_node("all_chunk").get_children():
		var tileMapPlanet :Node = chunk.get_node("world_generation").get_node("TileMap")
		var treePlanet :Node = chunk.get_node("world_generation").get_node("tree_gen")
		if len(tileMapPlanet.get_used_cells(0)) != 0:
			SaveLoad.saveFileData.actual_planet["chunk_load"][str(chunk.global_position)] = []
			for cell : Vector2i in tileMapPlanet.get_used_cells(0):
				SaveLoad.saveFileData.actual_planet["chunk_load"][str(chunk.global_position)].append({
					"position" = cell,
					"source_id" = tileMapPlanet.get_cell_source_id(0, cell)
				})
			for cell : Vector2i in tileMapPlanet.get_used_cells(1):
				SaveLoad.saveFileData.actual_planet["chunk_load"][str(chunk.global_position)].append({
					"position" = cell,
					"source_id" = tileMapPlanet.get_cell_source_id(1, cell)
				})
		for tree in treePlanet.get_children():
			print(tree)
			var tileTree :Array = []
			print(tree.get_child(0))
			for cell :Vector2 in tree.get_child(0).get_used_cells(0):
				print(cell)
				tileTree.append({
					"position" : cell,
					"source_id" : tree.get_child(0).get_cell_source_id(0,cell)
				})
			SaveLoad.saveFileData.actual_planet["tree"].append({
				"position" : tree.global_position,
				"tile" : tileTree
			})
	SaveLoad.saveFileData.actual_planet["seed_planet"] = planet_instance.seed_planet
	SaveLoad.saveFileData.actual_planet["seed_ore"] = planet_instance.seed_ore
	
	match planet_name:
		"Planet001":
			SaveLoad.saveFileData.planet001_create = SaveLoad.saveFileData.actual_planet
			SaveLoad.saveFileData.planet002_status = true
		"Planet002":
			SaveLoad.saveFileData.planet002_create = SaveLoad.saveFileData.actual_planet
			SaveLoad.saveFileData.planet002_status = true
