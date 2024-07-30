class_name InventoryUI extends Control
@onready var player_slot_container: GridContainer = %PlayerSlotContainer
@onready var other_slot_container: GridContainer = %OtherSlotContainer
@onready var other_inventory_panel: Control = $HBoxContainer/OtherInventoryPanel

var inventory: InventoryComponent = null
var show_inventory_ui: bool = true

const INVENTORY_SLOT = preload("res://ui/InventoryUI/inventory_slot.tscn")
# 
var inventory_slots: Array[InventorySlot] = []

func update_other_grid_slots():
	other_inventory_panel.visible = show_inventory_ui
	if not show_inventory_ui:
		return
			
	generate_inventory_slot(inventory, other_slot_container)
			
func update_player_grid_slots():
	var player_inventory = EventBus.player.inventory
	generate_inventory_slot(player_inventory, player_slot_container)

func generate_inventory_slot(inventory: InventoryComponent, container_node: GridContainer):
	var inventory_slot = inventory.inventory_slot
	var slot_ui_size := inventory_slot.size()
	
	for i in slot_ui_size:
		var slot_scene := INVENTORY_SLOT.instantiate()
		container_node.add_child(slot_scene)
		if i < inventory_slot.size() and inventory_slot[i].item != null:
			slot_scene.set_texture(inventory_slot[i].item.item_texture)
			slot_scene.set_quantity(inventory_slot[i].item_quantity)
		else:
			slot_scene.set_texture(null)
			slot_scene.set_quantity(0)

		slot_scene.curr_inventory = inventory
		slot_scene.curr_index = i

func _ready() -> void:
	visibility_changed.connect(func():
		get_tree().paused = visible
	)

func _input(event):
	if event.is_action_pressed("setting"):
		hide()
		EventBus.hide_inventory_ui.emit()
		get_window().set_input_as_handled()
		clear()
	


func clear():
	var child_count = player_slot_container.get_child_count()
	for i in child_count:
		var child = player_slot_container.get_child(child_count - i - 1)
		if child != null:
			child.queue_free()
	
	var other_child_count = other_slot_container.get_child_count()
	for i in child_count:
		var child = other_slot_container.get_child(other_child_count - i - 1)
		if child != null:
			child.queue_free()
	
func show_pause():
	update_player_grid_slots()
	update_other_grid_slots()
	show()
