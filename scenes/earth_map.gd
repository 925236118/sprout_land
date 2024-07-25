extends TileMap

func _ready() -> void:
	GlobalPlants.update_earth_map_tiles.connect(on_update_earth_map_tiles)

func on_update_earth_map_tiles():
	notify_runtime_tile_data_update(0)

func _use_tile_data_runtime_update(_layer: int, _coords: Vector2i) -> bool:
	return true
	
func _tile_data_runtime_update(_layer: int, coords: Vector2i, tile_data: TileData) -> void:
	if GlobalPlants.watered_pos.has(coords):
		tile_data.modulate = Color(.73, .58, .48, 1.0)
	else:
		tile_data.modulate = Color.WHITE
