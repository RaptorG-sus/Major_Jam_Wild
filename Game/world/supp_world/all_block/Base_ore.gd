extends Node2D
class_name Ore

@export var all_loot :Array[InvSlot]


func _ready() -> void:
	$HitboxComponent.set_script(PreloadData.hitboxcomponent_preload)
