extends Node2D
@onready var game_setting_ui = $UILayer/GameSettingUI

#@onready var ground_map: TileMap = $GroundMap

#@onready var t = preload("res://assets/Sprout Lands - Sprites - premium pack/Tilesets/ground tiles/New tiles/Darker_Grass_Tile_Layers.png")

func _ready() -> void:
	#(ground_map.tile_set.get_source(0) as TileSetAtlasSource).texture = t
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("setting"):
		if game_setting_ui.is_show:
			game_setting_ui.hide_setting()
		else:
			game_setting_ui.show_setting()
