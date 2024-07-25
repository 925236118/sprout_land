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

func on_plant_plant(pos: Vector2):
	var plant_pos = earth_map.local_to_map(ground_map.to_local(pos))
	var earth_tile_data = earth_map.get_cell_tile_data(EarthDirtLayer, plant_pos)
	var plant_tile_data = plants_map.get_cell_tile_data(PlantsLayer, plant_pos)
	
	if earth_tile_data == null:
		print("not on dirt")
		return
	
	if plant_tile_data != null:
		print("already plant")
		return
	
	plants_map.set_cell(PlantsLayer, plant_pos, 0, Vector2i(0, 1))
	
	pass
