extends Node

var pickaxe_preload :PackedScene = preload("res://Characters/Player/Interaction/pickaxe.tscn")

var inventory_preload :Inv = preload("res://Ressource/Player_inventory.tres")
var recipes_preload :ArrayCraftingRecipes = preload("res://Ressource/all_recipes.tres")
var requirement_preload :PackedScene = preload("res://Characters/Player/Inventory/recipe_requirement.tscn")

var loot_preload :PackedScene = preload("res://SomeSystem/Looting_System/base_loot.tscn")

var hitboxcomponent_preload :Script = preload("res://Component/HitboxComponent.gd")
