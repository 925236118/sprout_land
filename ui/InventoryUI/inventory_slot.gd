class_name InventorySlotUI extends Control
@onready var item_texture: TextureRect = $ItemTexture
@onready var item_quantity: Label = $ItemQuantity

var curr_inventory: InventoryComponent = null
var curr_index: int

func set_texture(texture: Texture2D):
	item_texture.texture = texture
	
func set_quantity(quantity: int):
	if quantity == 0:
		item_quantity.text = ""
	else:
		item_quantity.text = "%d" % quantity

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(generate_drag_preview(item_texture.texture))
	return {
		"from": curr_inventory,
		"index": curr_index,
		"from_slot": self
	}

func generate_drag_preview(texture: Texture2D) -> Control:
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	texture_rect.size = Vector2(32, 32)
	return texture_rect

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var from_inventory := data.from as InventoryComponent
	var from_index := data.index as int
	var from_slot_ui := data.from_slot as InventorySlotUI
	
	if from_inventory == curr_inventory and from_index == curr_index:
		return
	
	if from_inventory.get_slot(from_index).item == null:
		return
	
	var from_data: Dictionary = from_inventory.remove_item(data.index)
	var to_data: Dictionary = curr_inventory.remove_item(curr_index)
	curr_inventory.add_item(from_data.item, from_data.quantity, curr_index)
	
	
	set_texture(curr_inventory.get_slot(curr_index).item.item_texture)
	set_quantity(curr_inventory.get_slot(curr_index).item_quantity)
	
	if to_data.has("item") and to_data.item != null:
		from_inventory.add_item(to_data.item, to_data.quantity, from_index)
		
		from_slot_ui.set_texture(from_inventory.get_slot(from_index).item.item_texture)
		from_slot_ui.set_quantity(from_inventory.get_slot(from_index).item_quantity)
	else:
		from_slot_ui.set_texture(null)
		from_slot_ui.set_quantity(0)
		
