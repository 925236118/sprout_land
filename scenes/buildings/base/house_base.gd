@tool

class_name BuildingMap extends TileMap
@export_range(0.1, 1.0) var min_tile_alpha: float = 0.1
@export var hide_tile: bool = false:
	set(val):
		hide_tile = val
		if Engine.is_editor_hint():
			set_layer_enabled(tile_layer, !val)

const tile_layer_name = "Tile"
var tile_layer: int
var layer_alpha = 1.0
var alpha_delta = 2.5


func _init() -> void:
	for i in get_layers_count():
		# Find the secret layer by name.
		if get_layer_name(i) == tile_layer_name:
			tile_layer = i

func _ready() -> void:
	set_process(false)
	
func _process(delta: float) -> void:
	if hide_tile:
		if layer_alpha > 0.2:
			layer_alpha = move_toward(layer_alpha, min_tile_alpha, alpha_delta * delta)
			set_layer_modulate(tile_layer, Color(1, 1, 1, layer_alpha))
		else:
			set_process(false)
	else:
		if layer_alpha < 1.0:
			layer_alpha = move_toward(layer_alpha, 1.0, alpha_delta * delta)
			set_layer_modulate(tile_layer, Color(1, 1, 1, layer_alpha))
		else:
			set_process(false)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("teemo is into house")
		hide_tile = true
		set_process(true)
		notify_runtime_tile_data_update(tile_layer)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		print("teemo is leave house")
		hide_tile = false
		set_process(true)
		notify_runtime_tile_data_update(tile_layer)

#func _tile_data_runtime_update(layer: int, coords: Vector2i, tile_data: TileData) -> void:
	#pass
#
#func _use_tile_data_runtime_update(layer: int, coords: Vector2i) -> bool:
	#return layer == tile_layer

