extends StateBase
@export var player: Player = null

@onready var use_tool_machine: AnimationNodeStateMachinePlayback = null
## 进入状态
func enter() -> void:
	super.enter()
	use_tool_machine = player.animation_tree.get("parameters/UseTool/playback")
	
	var animation_tree_node_name = ""
	# 如果有动画树节点,则播放动画
	if GlobalTool.tool_state_name.has(GlobalTool.current_tool):
		animation_tree_node_name = GlobalTool.tool_state_name[GlobalTool.current_tool]
		
		player.machine.travel("UseTool")
		GlobalTool.is_using_tool = true
		await get_tree().create_timer(0.01).timeout
		use_tool_machine.travel(animation_tree_node_name)
	# 根据工具触发逻辑
	match GlobalTool.current_tool:
		"hoe":
			await get_tree().create_timer(0.5).timeout
			var dig_pos = player.global_position + player.last_direction * 12
			GlobalPlants.dig_earth.emit(dig_pos)
		"seed":
			var plant_pos = player.global_position
			GlobalPlants.plant_plant.emit(plant_pos)
		_:
			pass

## 退出状态
func exit() -> void:
	pass

## 渲染帧触发
func process_update(delta: float) -> void:
	# 动画播放结束后退出当前模式
	if use_tool_machine.get_current_node() == "End":
		GlobalTool.is_using_tool = false
		state_machine.change_state("Idle")

## 物理帧触发
func physical_process_update(delta: float) -> void:
	pass
