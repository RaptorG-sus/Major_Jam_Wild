extends Node2D

@export var play_scene : Array             # Transmis par des boutons lors de la CREATION de la planet (non pas le chargement)
var planet_instance
var planet_name

func _ready() -> void:
	SaveLoad.load_data()
	var planet = PlanetData.allPlanetData[PlanetData.planet_name]["Scene"]
	planet_instance = planet.instantiate()
	planet_instance.buildPlanet()
	add_child(planet_instance)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		print("save dans le scene principal")
		SaveLoad.saveFileData.planet001_status = true
		_save_planet()
		SaveLoad.save_data()

func _save_planet():
	planet_name = PlanetData.planet_name
	var tileMapPlanet = planet_instance.get_node("world_generation").get_node("TileMap")
	for cell in tileMapPlanet.get_used_cells(0):
		SaveLoad.saveFileData.actual_planet.append({
			"position": cell,
			"source_id": tileMapPlanet.get_cell_source_id(0,cell),
		})
	match planet_name:
		"Planet001":
			for cell in tileMapPlanet.get_used_cells(0):
				SaveLoad.saveFileData.planet001_create.append({
					"position": cell,
					"source_id": tileMapPlanet.get_cell_source_id(0,cell)
				})
