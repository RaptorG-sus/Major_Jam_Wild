extends Node2D
class_name HealthComponent

@onready var loot_scene :PackedScene = preload("res://world/supp_world/loot/base_loot.tscn")
@onready var Health_bar = $Health_bar

@export var Max_health :int

var hp : float


func _ready() -> void:
	hp = Max_health
	Health_bar.hide()
	Health_bar.max_value = Max_health
	Health_bar.value = Health_bar.max_value
	

func damage(attack :Attack) -> void:
	hp -= attack.attack_damage
	
	Health_bar.show()
	Health_bar.value = hp
	
	if hp <= 0:

		var parent = get_parent()
		
		#parent.destroy()
		if parent is block:
			parent.break_tree()
		parent.queue_free()

	
	
func loot_spawn(parent) -> void:
	
	var array_loot = parent.loot
	
	for loot in array_loot:
		var r = randi_range(-10, 10)
		var s = randi_range(-10, 10)
		var new_loot = loot_scene.instantiate()
		$".."/"..".add_child(new_loot)
		new_loot.global_position = global_position + Vector2(r,s)
		new_loot.item = loot
		
	parent.queue_free()
