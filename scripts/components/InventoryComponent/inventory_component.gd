class_name InventoryComponent extends Node2D

@export var slot_count: int = 10
@export var inventory_slot: Array[InventorySlot] = []

func get_inventory_node() -> InventoryComponent:
	return self
	
func list():
	return inventory_slot

func get_slot(index: int) -> InventorySlot:
	if index < inventory_slot.size() && index >= 0:
		return inventory_slot[index]
	else: 
		return null

func add_item(item: InventoryItem, quantity: int = 1, index: int = -1):
	if index == -1:
		index = get_first_empty_slot()
	var slot: InventorySlot = get_slot(index)
	if slot.item != null:
		pass
	
	pass

func remove():
	pass

func switch():
	
	pass

var is_full: bool = false:
	get:
		var full = true
		for slot in inventory_slot:
			if slot.item_quantity == 0:
				full = false
				break
		return full

func get_first_empty_slot() -> int:
	for index in inventory_slot.size():
		var slot: InventorySlot = get_slot(index)
		if slot == null:
			return -1
		if slot.item_quantity == 0:
			return index
	return -1

func get_item(index: int = 0) -> InventoryItem:
	var slot = get_slot(index)
	if slot != null:
		return slot.item
	return null

func set_enable(index: int, enable: bool) -> void:
	inventory_slot[index].slot_disable = !enable

func is_enable(index: int) -> bool:
	return inventory_slot[index].slot_disable
