extends Node2D
class_name HealthComponent

@export var Max_health :int

var hp : float


func _ready() -> void:
	hp = Max_health
	$ColorDark.hide()
	$ColorGreen.hide()
	

func damage(attack :Attack) -> void:
	hp -= attack.attack_damage
	
	$ColorDark.show()
	$ColorGreen.show()
	
	$ColorGreen.size.x = hp * 10 / Max_health
	
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
	
