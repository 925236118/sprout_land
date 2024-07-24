extends StateBase
@export var player: Player = null

@onready var use_tool_machine: AnimationNodeStateMachinePlayback = null
## 进入状态
func enter() -> void:
	super.enter()
	use_tool_machine = player.animation_tree.get("parameters/UseTool/playback")
	
	var animation_tree_node_name = ""
	if GlobalTool.tool_state_name.has(GlobalTool.current_tool):
		animation_tree_node_name = GlobalTool.tool_state_name[GlobalTool.current_tool] 
	#match player.current_tool:
		#"hoe":
			#animation_tree_node_name = "Hoe"
		#"axe":
			#animation_tree_node_name = "Axe"
		#"kettle":
			#animation_tree_node_name = "Kettle"
		#"item":
			#animation_tree_node_name = "Item"
		#_:
	else:
		push_error("wrong tool name")

	player.machine.travel("UseTool")
	await get_tree().create_timer(0.01).timeout
	use_tool_machine.travel(animation_tree_node_name)

## 退出状态
func exit() -> void:
	pass

## 渲染帧触发
func process_update(delta: float) -> void:
	if use_tool_machine.get_current_node() == "End":
		state_machine.change_state("Idle")

## 物理帧触发
func physical_process_update(delta: float) -> void:
	pass
