extends CharacterBody2D

@export var inv :Inv 

@onready var player_stat :ArmorData = ArmorData.new(10, 0, 300)
# Les stats du player

# Les scenes des outils de farm + arme de mélée
var tools :PackedScene = preload("res://Player/Interaction/tools.tscn")
var axe :PackedScene = null
var pickaxe :PackedScene = null

var usable :InvItem = null


# Gère la direction du player 
var direction :float = 0
var direction2 :=Vector2.ZERO
# L'outil ou arme en main du player
var actual_scene :PackedScene = tools
# Pour éviter de spamer
var can_attack :bool = false
# Modifie la vitesse en fonction de la taille du sprite du player
var taille_sprite :int = 64


func _ready() -> void:
	if !($Inv_ui.update_player_stat.is_connected(stat_update)):
		$Inv_ui.update_player_stat.connect(stat_update)
	if !($Inv_ui.usable.is_connected(full_usable)):
		$Inv_ui.usable.connect(full_usable)

	$HealthComponent.Max_health = player_stat.hp


func _physics_process(delta: float) -> void:
	# Gère la vitesse ( 64 totalement arbitraire )
	#velocity = delta * Vector2(direction, 1) * player_stat.speed * taille_sprite
	velocity = delta * direction2 * player_stat.speed * taille_sprite
	move_and_slide()


func _input(event: InputEvent) -> void:
	# Gère la direction de démplacement du perso ( 4 point cardinaux )
	#direction = Input.get_axis("gauche", "droite")
	direction2 = Input.get_vector("gauche", "droite", "haut", "bas")
	direction2.normalized()
	# Gère l'animation du joueur, en fonction de ses déplacements ( en com pour l'instant )
	"""	match(direction):
		1: animation.play("Sprit_right")
		-1: animation.play("Sprit_left")
		0:
			animation.stop()
			animation.set_frame(0)
	"""
	# Gère l'attaque du joueur
	if event.is_action_pressed("Interaction"):
		match usable.item_data:
			ItemData : pass
			AttackData : attack()
			ArmorData : return
			HealData : heal()
		can_attack = false
		attack()
		
# Génère la scene associer à l'outil pour mettre des dégats aux features
func attack() -> void:
	if can_attack:
		var player_attack 
		match usable.name:
			"axe" : player_attack = axe.instantiate()
			"pickaxe" : player_attack = pickaxe.instantiate()
			"*" : return
			
		player_attack.attack_end.connect(_on_attack_end)
		add_child(player_attack)

		player_attack.look_at(get_global_mouse_position())


func _on_attack_end() -> void:
	if usable != null:
		can_attack = true

func heal() -> void:
	var item = usable.item_data
	usable = null
	$HealthComponent.heal(item)
	


func stat_update(stat :ArmorData) ->void:
	player_stat.hp = stat.hp
	player_stat.armor = stat.armor
	player_stat.speed = stat.speed


func full_usable(slot :InvSlot) -> void:
	if slot != null && slot.item != null:
		usable = slot.item
	else:
		# Reste (loot ... )
		usable = null
	
func collect(item) -> void:
	inv.insert(item)
