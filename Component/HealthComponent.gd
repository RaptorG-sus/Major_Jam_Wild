extends Node2D
class_name HealthComponent


@onready var Health_bar = $Health_bar

@export var Max_health :int

var hp : float


func _ready() -> void:
	hp = Max_health
	#Health_bar.hide()
	Health_bar.max_value = Max_health
	Health_bar.value = Health_bar.max_value
	

func damage(attack :Attack) -> void:
	hp -= attack.attack_damage
	
	Health_bar.show()
	Health_bar.value = hp
	
	if hp <= 0:

		var parent = get_parent()
		

		#parent.destroy()

		parent.queue_free()

	
func loot_spawn(parent) -> void:
	
	var array_loot = parent.loot
	
	for loot in array_loot:
		var r = randi_range(-10, 10)
		var s = randi_range(-10, 10)
		loot = loot.instantiate()
		$".."/"..".add_child(loot)
		loot.global_position = global_position + Vector2(r,s)

	parent.queue_free()
	
