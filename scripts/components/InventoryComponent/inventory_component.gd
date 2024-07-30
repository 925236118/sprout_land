class_name InventoryComponent extends Node2D

@export var slot_count: int = 10
@export var inventory_slot: Array[InventorySlot] = []

func _ready() -> void:
	for i in inventory_slot.size():
		if inventory_slot[i] == null:
			inventory_slot[i] = InventorySlot.new()

func get_inventory_node() -> InventoryComponent:
	return self

func list():
	return inventory_slot

func get_slot(index: int) -> InventorySlot:
	if index < inventory_slot.size() && index >= 0:
		return inventory_slot[index]
	else: 
		return null

func add_item(item: InventoryItem, quantity: int = 1, index: int = -1) -> Dictionary:
	
	if index == -1:
		index = get_first_empty_slot()
	var slot: InventorySlot = get_slot(index)
	
	var removed_item: Dictionary = {}
	if slot.item != null:
		removed_item = remove_item(index)
	slot.item = item
	slot.item_quantity = quantity
	return removed_item

func remove_item(index: int) -> Dictionary:
	var slot = get_slot(index)
	if slot == null:
		return {}
	var result: Dictionary = {
		"item": slot.item,
		"quantity": slot.item_quantity
	}
	slot.item = null
	slot.item_quantity = 0
	return result

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
