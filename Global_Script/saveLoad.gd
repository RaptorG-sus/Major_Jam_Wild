extends Node

const save_location = "user://SaveFile.tres"

var saveFileData: SaveDataResource = SaveDataResource.new()

func _ready() -> void:
    load_data()

func save_data() -> void:
    print("save in saveload")
    ResourceSaver.save(saveFileData,save_location)

func load_data() -> void:
    print("load in saveload")
    if FileAccess.file_exists(save_location):
        saveFileData = ResourceLoader.load(save_location).duplicate(true)