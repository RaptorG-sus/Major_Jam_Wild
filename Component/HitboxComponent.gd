extends Area2D
class_name HitboxComponent


@export var Max_health :int

var hp : float
var last_damage_time :float = 0.0
const DAMAGE_COOLDOWN :float = 0.1 # Variable totalement arbitraire


func _ready() -> void:
	hp = Max_health


func damage(attack :AttackData) -> void:
	#Cooldown pour évité une surcharge et aussi de mettre plusieur coup avec un seul
	if Time.get_ticks_msec() / 1000.0 - last_damage_time < DAMAGE_COOLDOWN:
		# On /1000 pour que ce soit des secondes
		return
	
	last_damage_time = Time.get_ticks_msec() / 1000.0

	DamageManager.append_queue(self, attack)
	
	
func _apply_damage(attack :AttackData) -> void:
	print("damage")
	hp -= attack.attack_damage
	if hp <= 0:
		# règle un probleme au niveau du moteur physique
		call_deferred("_death")
		
		
func _death() -> void:
	DestructionManager.append_queue(self)
	

func _apply_destruction() -> void:
	var parent :Node2D = get_parent()

		
	if parent is block:
		parent.break_tree()
	elif parent is Ore:
		_loot_spawn(parent)
		parent.get_parent().erase_cell(0,Vector2i(int(parent.position.x/16),int(parent.position.y/16)))
	else:
		parent.queue_free()
		
		
func heal(item :HealData) -> void:

	var boucle :float = item.heal_time
	var add_hp :float = float(item.heal)/item.heal_time
	
	while (boucle > 0):
		hp += add_hp
		boucle -= 1
		
	if (hp > Max_health):
		hp = Max_health


func _loot_spawn(parent :Node2D) -> void:
	
	var array_loot :Array[InvSlot] = parent.all_loot
	var grand_parent :Node2D = parent.get_parent()
	var decalage :Vector2 
	var gonna_loot :int
	var new_loot :Node2D
	
	for loot in array_loot:
		gonna_loot = randi_range(0, 10)
		if gonna_loot == 0: 
			new_loot = PoolManager.get_in_pool(0)
			
			new_loot.slot = loot
			new_loot.get_child(0).texture = loot.item.texture

			decalage = Vector2(randi_range(-8, 8), randi_range(-8, 8))
			new_loot.global_position = global_position + decalage
			
	parent.queue_free()
