extends Control


func _on_hoe_pressed() -> void:
	GlobalTool.current_tool = "hoe"

func _on_axe_pressed() -> void:
	GlobalTool.current_tool = "axe"

func _on_kettle_pressed() -> void:
	GlobalTool.current_tool = "kettle"

func _on_seed_pressed() -> void:
	GlobalTool.current_tool = "seed"
