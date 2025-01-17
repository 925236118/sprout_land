extends CharacterBody2D
class_name Player
@export var inventory: InventoryComponent = null
@onready var animation_player = $AnimationPlayer

@onready var animation_tree = $AnimationTree
@onready var machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@onready var opration_check: RayCast2D = $OprationCheck

var direction = Vector2.ZERO
# 最后一帧面朝的方向
var last_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	EventBus.player = self
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		EventBus.show_inventory_ui.emit(null, false)

func _physics_process(_delta: float) -> void:
	if GlobalTool.is_using_tool:
		return
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		last_direction = direction
	update_animation_tree_param(last_direction)
	
func update_animation_tree_param(dire):
	if dire == Vector2.ZERO:
		return
	animation_tree.set("parameters/Idle/blend_position", dire)
	animation_tree.set("parameters/Walk/blend_position", dire)
	animation_tree.set("parameters/UseTool/Hoe/blend_position", dire)
	animation_tree.set("parameters/UseTool/Axe/blend_position", dire)
	animation_tree.set("parameters/UseTool/Kettle/blend_position", dire)
