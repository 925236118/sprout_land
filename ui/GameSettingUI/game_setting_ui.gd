extends Control

var is_show: bool = false

func _ready() -> void:
	hide_setting()

func show_setting():
	is_show = true
	visible = is_show
	#set_process(false)
	#set_physics_process(false)
	#if get_tree() != null:
		#get_tree().set_process(false)

func hide_setting():
	is_show = false
	visible = is_show
	#set_process(true)
	#set_physics_process(true)
	#if get_tree() != null:
		#get_tree().set_process(true)
