extends Control

var target_scene : String = "res://Game/Scene_principal/scene_principal.tscn"
var progress : Array[float]
var loading_status : int

func _ready() -> void:
    ResourceLoader.load_threaded_request(target_scene)

func _process(_delta : float) -> void :


    loading_status = ResourceLoader.load_threaded_get_status(target_scene,progress)


    if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
        get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene))
    else:
        print(loading_status)
