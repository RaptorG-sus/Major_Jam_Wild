extends Node2D

var planet_load

func buildPlanet(flag = false):
    if SaveLoad.saveFileData.planet001_status and flag:
        $world_generation.queue_free()
        planet_load = (SaveLoad.saveFileData.planet001_create)
        var planet_load_step2 = planet_load.instantiate()
        add_child(planet_load_step2)
    else:
        print("test")
        $world_generation.planet_name = "Planet001"
        $world_generation.total_generation()
    