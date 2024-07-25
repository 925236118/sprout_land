extends Node2D
@onready var ground_map: TileMap = $GroundMap
@onready var earth_map: TileMap = $EarthMap
@onready var plants_map: TileMap = $PlantsMap

var GroundGrassLayer = 0
var EarthDirtLayer = 0
var PlantsLayer = 0

func _ready() -> void:
	GlobalPlants.dig_earth.connect(on_dig_earth)
	GlobalPlants.plant_plant.connect(on_plant_plant)
	GlobalPlants.water_earth.connect(on_water_earth)

func on_dig_earth(pos: Vector2):
	var dig_pos = ground_map.local_to_map(ground_map.to_local(pos))
	# 获取瓦片数据
	var ground_tile_data = ground_map.get_cell_tile_data(GroundGrassLayer, dig_pos)
	var earth_tile_data = earth_map.get_cell_tile_data(EarthDirtLayer, dig_pos)
	
	if ground_tile_data == null:
		return
	# 该地面是否可以挖掘
	var can_dig = ground_tile_data.get_custom_data("can_dig")
	if !can_dig:
		return
	# 该土地是否已经挖掘
	if earth_tile_data != null:
		return
	earth_map.set_cells_terrain_connect(EarthDirtLayer, [dig_pos], 0, 0)

func on_water_earth(pos: Vector2):
	var water_pos = earth_map.local_to_map(ground_map.to_local(pos))
	if not GlobalPlants.watered_pos.has(water_pos):
		GlobalPlants.watered_pos.append(water_pos)
		GlobalPlants.update_earth_map_tiles.emit()

func on_plant_plant(pos: Vector2):
	var plant_pos = earth_map.local_to_map(ground_map.to_local(pos))
	var earth_tile_data = earth_map.get_cell_tile_data(EarthDirtLayer, plant_pos)
	var plant_tile_data = plants_map.get_cell_tile_data(PlantsLayer, plant_pos)
	
	if earth_tile_data == null:
		#print("not on dirt")
		return
	
	if plant_tile_data != null:
		#print("already plant")
		return
	var plant = GlobalPlants.plants[GlobalPlants.current_plant]
	
	# 种植种子
	if plant.life is Array and !plant.life.size():
		return

	plants_map.set_cell(PlantsLayer, plant_pos, plant.source_id, plant.life[0].coord)
	
	# 设置植物生命周期
	plant_tile_data = plants_map.get_cell_tile_data(PlantsLayer, plant_pos)
	plant_tile_data.set_custom_data("plant", GlobalPlants.current_plant)
	plant_tile_data.set_custom_data("life", 0)
	plant_tile_data.set_custom_data("require_time", plant.life[0]["require_time"])
