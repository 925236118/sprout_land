extends Control

const GAME = preload("res://scenes/game.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)
