extends Node2D

@export var play_scene : PackedScene             # Transmis par des boutons lors de la CREATION de la planet (non pas le chargement)

func _ready() -> void:
	var planet = PlanetData.allPlanetData[PlanetData.planet_name]["Scene"]
	print("test_2")
	var planet_instance = planet.instantiate()
	planet_instance.buildPlanet()
	add_child(planet_instance)
