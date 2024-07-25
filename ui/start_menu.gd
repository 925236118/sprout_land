extends Control

const GAME = preload("res://scenes/game.tscn")

func _on_new_game_pressed():
	get_tree().change_scene_to_packed(GAME)
