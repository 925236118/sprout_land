extends Node

const START_MENU = preload("res://ui/StartMenu/start_menu.tscn")
const FARM = preload("res://scenes/maps/farm.tscn")

@onready var Scene = {
	"start_menu": START_MENU,
	"farm": FARM,
}

func change_scene(scene_name: String):
	if not Scene.has(scene_name):
		push_error("wrong scene name")
		return
	get_tree().paused = false
	get_tree().change_scene_to_packed(Scene[scene_name])

func back_to_title():
	get_tree().change_scene_to_packed(START_MENU)


func goto_farm():
	get_tree().change_scene_to_packed(FARM)
