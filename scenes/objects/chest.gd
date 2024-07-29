@tool

class_name Chest extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

enum Direction {
	DOWN,
	LEFT,
	RIGHT
}

@export var direction: Direction = Direction.DOWN:
	set(value):
		direction = value
		match direction:
			Direction.DOWN:
				scale.x = 1
				animation_player.play("Open")
				animation_player.stop()
				pass
			Direction.LEFT:
				scale.x = -1
				animation_player.play("OpenLeft")
				animation_player.stop()
				pass
			Direction.RIGHT:
				scale.x = 1
				animation_player.play("OpenLeft")
				animation_player.stop()
				pass

@export var inventory: InventoryComponent = null

var is_chest = true
var is_open = false
func _ready() -> void:
	EventBus.hide_inventory_ui.connect(hide_inventory_ui)
	pass

func open():
	match direction:
		Direction.DOWN:
			scale.x = 1
			animation_player.play("Open")
		Direction.LEFT:
			scale.x = -1
			animation_player.play("OpenLeft")
		Direction.RIGHT:
			scale.x = 1
			animation_player.play("OpenLeft")
	await animation_player.animation_finished
	EventBus.show_inventory_ui.emit(inventory)
	is_open = true
	pass

func hide_inventory_ui():
	if not is_open:
		return
	is_open = false
	match direction:
		Direction.DOWN:
			scale.x = 1
			animation_player.play_backwards("Open")
		Direction.LEFT:
			scale.x = -1
			animation_player.play_backwards("OpenLeft")
		Direction.RIGHT:
			scale.x = 1
			animation_player.play_backwards("OpenLeft")
