extends Node

var planet_name : String = "Planet001"

var debug_planet : bool

var allPlanetData : Dictionary = {
	"Planet001" : {
		"TileSet" = "res://Game/world/All_world/Planet_001/TileSet_Planet_001.tres",
		"TileSetTree" = "res://Game/world/supp_world/nature/all_tree/tree_gen/tilemap_tree.tres",
		"Scene" = load("res://Game/world/All_world/Planet_001/Planet_001.tscn")
	},
	"Planet002":{
		"TileSet" = "res://Game/world/All_world/Planet_002/TileSet_Planet_002.tres",
		"TileSetTree" = "res://Game/world/supp_world/nature/all_tree/tree_gen/tilemap_tree.tres",
		"Scene" = load("res://Game/world/All_world/Planet_002/Planet_002.tscn")
	}
}
