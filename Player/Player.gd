extends CharacterBody2D


@export var speed :float


# Les scenes des outils de farm + arme de mélée
var tools :PackedScene = preload("res://Player/Interaction/tools.tscn")
var axe :PackedScene = null
var pickaxe :PackedScene = null


# Gère la direction du player 
var direction :float = 0
var direction2 :=Vector2.ZERO
# L'outil ou arme en main du player
var actual_scene :PackedScene = tools
# Pour éviter de spamer
var can_attack :bool = true
# Modifie la vitesse en fonction de la taille du sprite du player
var taille_sprite :int = 64


func _physics_process(delta: float) -> void:
	# Gère la vitesse ( 64 totalement arbitraire )
	#velocity = delta * Vector2(direction, 1) * speed * taille_sprite
	velocity = delta * direction2 * speed * taille_sprite
	move_and_slide()


func _input(event: InputEvent) -> void:
	# Gère la direction de démplacement du perso ( 4 point cardinaux )
	#direction = Input.get_axis("gauche", "droite")
	direction2 = Input.get_vector("gauche", "droite", "haut", "bas")
		
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

	player_attack.look_at(Vector2(direction, 0))


func _on_attack_end() -> void:
	can_attack = true
