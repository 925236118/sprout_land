extends Node2D

func _ready() -> void:
	pass


func _on_save_game_pressed() -> void:
	GameSaver.save_game("1.txt")
	pass # Replace with function body.


func _on_load_game_pressed() -> void:
	var load_file = GameLoader.load_game("1.txt")
	if load_file.is_empty():
		print("empty load")
	for key in load_file:
		print(key, ": ", load_file[key])


func _on_load_list_pressed() -> void:
	var file_name_list: PackedStringArray = GameLoader.show_load_list()
	for file_name in file_name_list:
		print(file_name)
	pass # Replace with function body.
