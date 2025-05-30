extends Node2D

@onready var noise = $Noise.texture.noise
@onready var map = $TileMap
@onready var seed_world = randi_range(1, 65536)
@onready var seed_ore = randi_range(1,256)

var earth_value : float = -0.25                                                                     # pour plus ou moins de grotte / rocher volant
var ore_value : float = 0.3
var tree_percentage : int = 5                                                                       # pourcentage d'arbre permettant changeant en fonction de la planete
var block = Vector2i(3,2)                                                                           # temporaire ou pas, block utilisé pour faire l'herbe
																									# block à utiliser pour les arbres etc...

var range_generation : int = 200

func _ready() -> void:
	terrain_generation()
	tree_generation()
	ore_generation()
	
	
func terrain_generation():
	noise.seed = seed_world                                                                         # genere la seed du monde
	for x in range(range_generation):
		var ground = abs(noise.get_noise_2d(x,0)*10)                                                # genere les petites buttes de terre permettant un monde plus agréable ( * 10 pour des buttes plus abruptes)
		for y in range(ground,500):
			if noise.get_noise_2d(x,y) > earth_value:                                               # genere en fonction du noise et aura plus ou moins de terre dependant de earthvalue
				map.set_cell(0,Vector2i(x,y),0,Vector2i(0,0),1)                                               # pose les blocks


func tree_generation():
	if tree_percentage > 0:                                                                         # verification initial pour éviter des faires des boucles infini si aucun arbre voulue
		for x in range(range_generation):
			if randi()%100 < tree_percentage:                                                       # pourcentage pour avoir l'arbre
				var y = 0
				while map.get_cell_source_id(0,Vector2i(x,y)) != 0:                          # pour poser le block au plus bas possible jusqu'a la hauteur voulue (suite du while)
					y+=1
				for i in range(10):
					map.set_cell(0,Vector2i(x,-i+(y-1)),2,Vector2i(0,0),1)                            # à remplacer par "load_scene_arbre(coord x, y patati patata)

func ore_generation():
	noise.seed = seed_ore                                                                           # genere prend une nouvelle seed pour les minerais
	for x in range(range_generation):                   
											  # adoucir les minerais
		for y in range(75,500):                                                                 # generation en y
			if noise.get_noise_2d(x,y) > ore_value and map.get_cell_source_id(0,Vector2i(x,y)) == 0:                 # placement des minerais
				map.erase_cell(0,Vector2i(x,y))
				map.set_cell(0,Vector2i(x,y),1,Vector2i.ZERO,1)
