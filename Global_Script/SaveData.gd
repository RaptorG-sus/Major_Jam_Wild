extends Resource
class_name SaveDataResource

@export var player_inv : Array[InvSlot]
@export var player_equipement : Array[InvSlot]
@export var player_active_slot : Array[InvSlot]

@export var planet001_status : bool = false
@export var planet001_create : Dictionary

@export var planet002_status : bool = false
@export var planet002_create : Dictionary

@export var planet003_status : bool = false
@export var planet003_create : Dictionary

@export var planet004_status : bool = false
@export var planet004_create : Dictionary

@export var planet005_status : bool = false
@export var planet005_create : Dictionary

@export var all_chunk : Dictionary = {}
@export var actual_planet : Dictionary

@export var futurPlanet : String = "Planet002"
@export var planet_name : String
