extends Node

var planet_name : String

var debug_planet : bool

var allPlanetData : Dictionary = {
	"Planet001" : {
		"TileSet" = "res://Game/world/All_world/Planet_001/TileSet_Planet_001.tres",
		"TileSetTree" = "res://Game/world/supp_world/nature/all_tree/tree_gen/tilemap_tree.tres",
		"Scene" = load("res://Game/world/All_world/Planet_001/Planet_001.tscn")
	}
}
