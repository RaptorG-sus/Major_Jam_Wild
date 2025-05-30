extends CharacterBody2D

@export var inv :Inv 
@export var speed :float


# Les scenes des outils de farm + arme de mélée
var tools :PackedScene = preload("res://Player/Interaction/tools.tscn")
var axe :PackedScene = null
var pickaxe :PackedScene = null


# Les stats du player
var player_stat :Player_stat = Player_stat.new()
# Gère la direction du player 
var direction :float = 0
var direction2 :=Vector2.ZERO
# L'outil ou arme en main du player
var actual_scene :PackedScene = tools
# Pour éviter de spamer
var can_attack :bool = true
# Modifie la vitesse en fonction de la taille du sprite du player
var taille_sprite :int = 64


func _ready() -> void:
	if !($Inv_ui.update_player_stat.is_connected(stat_update)):
		$Inv_ui.update_player_stat.connect(stat_update)
		
	player_stat.hp = 10
	player_stat.armor = 0
	player_stat.speed = speed
	
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
	if event.is_action_pressed("Interaction") and can_attack and actual_scene != null:
		can_attack = false
		attack()
		
# Génère la scene associer à l'outil pour mettre des dégats aux features
func attack() -> void:
	var player_attack = actual_scene.instantiate()
	player_attack.attack_end.connect(_on_attack_end)
	add_child(player_attack)

	player_attack.look_at(get_global_mouse_position())


func _on_attack_end() -> void:
	can_attack = true


func stat_update(stat :Player_stat) ->void:
	player_stat.hp = stat.hp
	player_stat.armor = stat.armor
	player_stat.speed = stat.speed

	
func collect(item) -> void:
	inv.insert(item)
