extends Node2D
class_name HealthComponent

@onready var Health_bar :ProgressBar = $Health_bar

@export var Max_health :int

var hp : float


func _ready() -> void:
	hp = Max_health
	Health_bar.hide()
	Health_bar.max_value = Max_health
	Health_bar.value = Health_bar.max_value
	

func damage(attack :AttackData) -> void:
	hp -= attack.attack_damage
	
	Health_bar.value = hp
	Health_bar.show()
	
	if hp <= 0:

		var parent :Node2D = get_parent()
		
		if parent is block:
			parent.break_tree()
		elif parent is Ore:
			loot_spawn(parent)
		else:
			parent.queue_free()


func heal(item :HealData) -> void:

	var boucle :float = item.heal_time
	var add_hp :float = item.heal/item.heal_time
	while (boucle > 0):
		hp += add_hp
		boucle -= 1
		
	if (hp > Max_health):
		hp = Max_health

	
func loot_spawn(parent :Node2D) -> void:
	
	var loot_scene :PackedScene = preload("res://loot/base_loot.tscn")
	# en construction
	var array_loot :Array[InvSlot] = parent.all_loot
	var grand_parent :Node2D = parent.get_parent()
	
	for loot in array_loot:
		var gonna_loot :int = randi_range(0, 10)
		if gonna_loot == 0: 
			var new_loot :Node2D = loot_scene.instantiate()
			var decalage :Vector2 = Vector2(randi_range(-8, 8), randi_range(-8, 8))
			
			new_loot.item = loot
			grand_parent.add_child(new_loot)
			new_loot.global_position = global_position + decalage
		
	parent.queue_free()
