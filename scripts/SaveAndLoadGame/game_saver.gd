class_name GameSaver extends Node

static func save_game(file_name):
	var file_path = GameSetting.game_file_path + file_name
	var json = GameLoader.load_game(file_name)
	
	
	# TODO: 修改json
	if not DirAccess.dir_exists_absolute(GameSetting.game_file_path):
		DirAccess.make_dir_absolute(GameSetting.game_file_path)
		
		
	var file: FileAccess = FileAccess.open(file_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(json, "\t"))
	file.close()
	
