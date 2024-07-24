extends CharacterBody2D
class_name Player

@onready var animation_player = $AnimationPlayer

@onready var animation_tree = $AnimationTree
@onready var machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")


var direction = Vector2.ZERO
# 最后一帧面朝的方向
var last_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
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
