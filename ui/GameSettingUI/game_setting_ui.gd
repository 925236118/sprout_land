extends Control

#var is_show: bool = false

func _ready() -> void:
	visibility_changed.connect(func():
		get_tree().paused = visible
	)

func _input(event):
	if event.is_action_pressed("setting"):
		hide()
		get_window().set_input_as_handled()

func show_pause():
	show()


func _on_exit_button_pressed():
	SceneManager.change_scene("start_menu")
	pass # Replace with function body.


func _on_resume_button_pressed():
	hide()
	pass # Replace with function body.
