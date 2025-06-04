extends Node2D
class_name Ore

@export var all_loot :Array[InvSlot]
@export var Max_health :int


func _ready() -> void:
	$HitboxComponent.set_script(PreloadData.hitboxcomponent_preload)
	$HitboxComponent.Max_health = Max_health

