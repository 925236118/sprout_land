class_name GameLoader extends Node

static func show_load_list() -> PackedStringArray:
	if not DirAccess.dir_exists_absolute(GameSetting.game_file_path):
		DirAccess.make_dir_absolute(GameSetting.game_file_path)
		
	var load_file_list: Array[String] = []
	var game_file_dir = DirAccess.open(GameSetting.game_file_path)
	if game_file_dir:
		game_file_dir.list_dir_begin()
		var file_name = game_file_dir.get_next()
		while file_name != "":
			if game_file_dir.current_is_dir():
				#print("发现目录：" + file_name)
				pass
			else:
				#print("发现文件：" + file_name)
				load_file_list.append(file_name)
			file_name = game_file_dir.get_next()
	else:
		push_error("尝试访问路径时出错。")
	
	return PackedStringArray(load_file_list)

static func load_game(file_name: String = "") -> Dictionary:
	if file_name == "":
		push_error("error load file name")
		return {}
		
	if not DirAccess.dir_exists_absolute(GameSetting.game_file_path):
		DirAccess.make_dir_absolute(GameSetting.game_file_path)
		return {}
	
	var file_path = GameSetting.game_file_path + file_name
	
	var file: FileAccess
	
	if FileAccess.file_exists(file_path):
		file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	else: 
		file = FileAccess.open(file_path, FileAccess.WRITE_READ)
	
	var file_str = ""
	
	while not file.eof_reached():
		file_str += file.get_line().trim_prefix("\t")
	#print("file_str", file_str)
	var json: Dictionary
	if file_str != "":
		json = JSON.parse_string(file_str)
	else:
		# 空文件
		return {}
	return json


