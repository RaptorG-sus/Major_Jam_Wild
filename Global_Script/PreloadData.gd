extends Node

var pickaxe_preload :PackedScene = preload("res://Characters/Player/Interaction/pickaxe.tscn")

var inventory_preload :Inv = preload("res://Ressource/Player_inventory.tres")
var recipes_preload :ArrayCraftingRecipes = preload("res://Ressource/all_recipes.tres")
var requirement_preload :PackedScene = preload("res://Characters/Player/Inventory/recipe_requirement.tscn")

var loot_preload :PackedScene = preload("res://SomeSystem/Looting_System/base_loot.tscn")

var hitboxcomponent_preload :Script = preload("res://Component/HitboxComponent.gd")

var chunk : PackedScene = preload("res://Game/world/gen_world/Chunk.tscn")
var tree_01 : PackedScene = preload("res://Game/world/supp_world/nature/all_tree/tree_gen/all_tree/tree001.tscn")
var tree_02 : PackedScene = preload("res://Game/world/supp_world/nature/all_tree/tree_gen/all_tree/tree002.tscn")
var tree_03 : PackedScene = preload("res://Game/world/supp_world/nature/all_tree/tree_gen/all_tree/tree003.tscn")
var tree_04 : PackedScene = preload("res://Game/world/supp_world/nature/all_tree/tree_gen/all_tree/tree004.tscn")

var scene_principal : PackedScene = preload("res://Game/Scene_principal/scene_principal.tscn")
var debug_zone : PackedScene = preload("res://debug/debug_zone.tscn")
var menu : PackedScene = preload("res://Game/UI/menu.tscn")

var loading_screen : PackedScene = preload("res://Game/UI/loading_screen.tscn")