class_name InventoryUI extends Control
@onready var slot_container: GridContainer = %SlotContainer

var inventory: InventoryComponent = null

const INVENTORY_SLOT = preload("res://ui/InventoryUI/inventory_slot.tscn")

var inventory_slots: Array[InventorySlot] = []:
	set(value):
		inventory_slots = value
		update_grid_slots()

func update_grid_slots():
	var inventory_size := inventory_slots.size()
	#var slot_ui_size = ceil(inventory_size / 5.0) * 5
	var slot_ui_size = inventory_size
	print("size ", inventory_size)
	for i in slot_ui_size:
		var slot_scene := INVENTORY_SLOT.instantiate()
		slot_container.add_child(slot_scene)
		if i < inventory_slots.size() and inventory_slots[i] != null:
			slot_scene.set_texture(inventory_slots[i].item.item_texture)
			slot_scene.set_quantity(inventory_slots[i].item_quantity)
		else:
			slot_scene.set_texture(null)
			slot_scene.set_quantity(0)
			

func _ready() -> void:
	visibility_changed.connect(func():
		get_tree().paused = visible
	)

func _input(event):
	if event.is_action_pressed("setting"):
		hide()
		EventBus.hide_inventory_ui.emit()
		get_window().set_input_as_handled()
		var child_count = slot_container.get_child_count()
		for i in child_count:
			var child = slot_container.get_child(child_count - i - 1)
			if child != null:
				child.queue_free()

func show_pause():
	show()
