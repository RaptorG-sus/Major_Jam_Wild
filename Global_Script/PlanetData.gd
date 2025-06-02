extends Node

var planet_name : String

var debug_planet : bool

var allPlanetData : Dictionary = {
	"Planet001" : {
		"TileSet" = "res://Game/world/All_world/Planet_001/TileSet_Planet_001.tres",
		"Scene" = load("res://Game/world/All_world/Planet_001/Planet_001.tscn")
	}
}
