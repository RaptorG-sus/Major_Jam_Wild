extends CharacterBody2D
class_name Player

@export var inv :Inv 
@export var base_player_stat : ArmorData

# Les stats du player
@onready var player_stat :ArmorData = ArmorData.new()
# Les scenes des outils de farm + arme de mélée
var axe :PackedScene = null
var pickaxe :PackedScene = PreloadData.pickaxe_preload

@onready var usable :InvItem = null


# Gère la direction du player 
var direction :float = 0
var direction2 :=Vector2.ZERO
# Pour éviter de spamer
var can_attack :bool = false
var can_move :bool = true
# Modifie la vitesse en fonction de la taille du sprite du player
var taille_sprite :int = 64

var last_velocity_x_sign : float = 1


func _ready() -> void:
	if !($Inv_ui.update_player_stat.is_connected(stat_update)):
		$Inv_ui.update_player_stat.connect(stat_update)
	if !($Inv_ui.usable.is_connected(full_usable)):
		$Inv_ui.usable.connect(full_usable)

	player_stat = base_player_stat.duplicate()

	$HitboxComponent.Max_health = player_stat.hp


func _physics_process(delta: float) -> void:
	# Gère la vitesse ( 64 totalement arbitraire )
	#velocity = delta * Vector2(direction, 1) * player_stat.speed * taille_sprite
	var gravity : float = 800
	var decay : float = player_stat.ground_speed_decay if is_on_floor() else player_stat.air_speed_decay
	var target_velocity_x : float = direction2.x * player_stat.speed * taille_sprite
	velocity.x = velocity.x+(target_velocity_x-velocity.x)*exp(-decay*delta)
	var velocity_x_sign : float = sign(velocity.x)
	if velocity_x_sign != last_velocity_x_sign:
		$AnimatedSprite2D.flip_h = (velocity.x < 0.0)
		last_velocity_x_sign = velocity_x_sign
	if is_on_floor():
		if Input.is_action_just_pressed("haut"):
			velocity.y = -player_stat.jump_strength
	else:
		velocity.y += delta*gravity
	move_and_slide()



func _input(event: InputEvent) -> void:
	# Gère la direction de démplacement du perso ( 4 point cardinaux )
	if can_move:
		#direction = Input.get_axis("gauche", "droite")
		direction2 = Input.get_vector("gauche", "droite", "haut", "bas")
		direction2.normalized()
	else :
		direction2 = Vector2.ZERO
		
	# Gère l'animation du joueur, en fonction de ses déplacements ( en com pour l'instant )
	"""	match(direction):
		1: animation.play("Sprit_right")
		-1: animation.play("Sprit_left")
		0:
			animation.stop()
			animation.set_frame(0)
	"""
	# Gère l'attaque du joueur
	if event.is_action_pressed("Interaction") && usable != null:
		can_move = false
		if usable.item_data is AttackData:
			_attack()
		elif usable.item_data is HealData:
			_heal()
		else :
			can_move = true
			# usable.item_data is ItemData or ArmorData
			pass 
		
		
# Génère la scene associer à l'outil pour mettre des dégats aux features
func _attack() -> void:
	if can_attack:
		can_attack = false
		var player_attack :Node2D
		if usable.name.begins_with("axe"):
			player_attack = axe.instantiate()
		elif usable.name.begins_with("pickaxe"):
			player_attack = pickaxe.instantiate()
		else:
			return
		player_attack.item = usable


		player_attack.attack_end.connect(_on_attack_end)
		add_child(player_attack)

		player_attack.look_at(get_global_mouse_position())
		player_attack.rotation_degrees -= 45


func _on_attack_end() -> void:
	if usable != null:
		can_attack = true
		can_move = true


func _heal() -> void:
	var item :HealData = usable.item_data
	usable = null
	$HitboxComponent.heal(item)


func stat_update(stat :ArmorData) ->void:
	player_stat.hp = base_player_stat.hp + stat.hp
	player_stat.armor = base_player_stat.armor + stat.armor
	player_stat.speed = base_player_stat.speed + stat.speed


func full_usable(slot :InvSlot) -> void:
	if slot != null && slot.item != null:
		usable = slot.item
		can_attack = true
	else:
		# Reste (loot ... )
		usable = null
		
	
func collect(item :InvSlot) -> void:
	inv.insert(item)
