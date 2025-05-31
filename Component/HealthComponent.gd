extends Node2D
class_name HealthComponent

@onready var loot_scene :PackedScene = preload("res://loot/base_loot.tscn")
@onready var Health_bar = $Health_bar

@export var Max_health :int

var hp : float


func _ready() -> void:
	hp = Max_health
	Health_bar.hide()
	Health_bar.max_value = Max_health
	Health_bar.value = Health_bar.max_value
	

func damage(attack :AttackData) -> void:
	hp -= attack.attack_damage
	
	Health_bar.show()
	Health_bar.value = hp
	
	if (hp > Max_health):
		hp = Max_health
	
	if hp <= 0:

		var parent = get_parent()
		
		#parent.destroy()
		if parent is block:
			parent.break_tree()
		elif parent is Ore:
			loot_spawn(parent)
		else:
			parent.queue_free()


func heal(item :HealData):

	var boucle = item.heal_time
	var add_hp :float = item.heal/item.heal_time
	while (boucle > 0):
		hp += add_hp
		boucle -= 1
		
	if (hp > Max_health):
		hp = Max_health

	
func loot_spawn(parent) -> void:
	
	# en construction
	var array_loot = parent.all_loot
	
	for loot in array_loot:
		var r = randi_range(-10, 10)
		var s = randi_range(-10, 10)
		var new_loot = loot_scene.instantiate()
		new_loot.item = loot
		$".."/"..".add_child(new_loot)
		new_loot.global_position = global_position + Vector2(r,s)

		
	parent.queue_free()
