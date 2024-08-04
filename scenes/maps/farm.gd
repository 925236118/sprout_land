extends Node2D
@onready var game_setting_ui = $UILayer/GameSettingUI

@onready var chest: Chest = $Chest
@onready var inventory_ui: InventoryUI = $UILayer/InventoryUI

#@onready var ground_map: TileMap = $GroundMap

#@onready var t = preload("res://assets/Sprout Lands - Sprites - premium pack/Tilesets/ground tiles/New tiles/Darker_Grass_Tile_Layers.png")

func _ready() -> void:
	#(ground_map.tile_set.get_source(0) as TileSetAtlasSource).texture = t
	#print(chest)
	#print(chest.inventory)
	#var item = chest.inventory.get_item(0)
	#print(item.item_name)
	#print(chest.inventory.get_slot(0).item_quantity)
	#inventory_ui.inventory_slots = chest.inventory.inventory_slot
	pass
	
	EventBus.show_inventory_ui.connect(show_inventory_ui)
	
func show_inventory_ui(inventory: InventoryComponent, show_inventory_ui: bool = true):
	if inventory != null:
		inventory_ui.inventory = inventory
		inventory_ui.inventory_slots = inventory.inventory_slot
		
	inventory_ui.show_inventory_ui = show_inventory_ui
	
	if not inventory_ui.visible:
		inventory_ui.show_pause()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("setting"):
		if not game_setting_ui.visible:
			game_setting_ui.show_pause()
