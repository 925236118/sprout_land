extends TileMap

var PlantLayer = 0

func _ready() -> void:
	GlobalPlants.update_plants_map_life.connect(on_update_plants_map_life)
	
func on_update_plants_map_life():
	#print("----- on_update_plants_map_life -----")
	var used_rect = get_used_rect()
	for x in used_rect.size.x:
		for y in used_rect.size.y:
			var coord_x = x + used_rect.position.x
			var coord_y = y + used_rect.position.y
			var coord = Vector2i(coord_x, coord_y)

			# 检查是否浇水, 未浇水的不成长
			if not GlobalPlants.watered_pos.has(coord):
				#print("未浇水")
				continue

			var tile_data = get_cell_tile_data(PlantLayer, coord)

			if tile_data == null:
				continue

			var plant_id = tile_data.get_custom_data("plant")
			var life = tile_data.get_custom_data("life")
			var require_time = tile_data.get_custom_data("require_time")
			#print("custom life ", life)
			#print("custom require_time ", require_time)
			require_time -= 1
			# 判断是否需要时间以达到
			if require_time > 0:
				tile_data.set_custom_data("require_time", require_time)
				continue

			#print("需要时间已到达 开始成长")
			# 需要时间已经到达,阶段成长
			var plant = GlobalPlants.plants[plant_id]
			var plant_life = plant.life as Array
			life += 1
			
			if life < plant_life.size():
				#print("life ", life)
				var next_life = plant_life[life]
				set_cell(PlantLayer, coord, plant.source_id, next_life.coord)
				tile_data = get_cell_tile_data(PlantLayer, coord)
				tile_data.set_custom_data("require_time", next_life.require_time)
				tile_data.set_custom_data("life", life)
				tile_data.set_custom_data("plant", plant_id)

			else:
				#print("已经成熟")
				continue

