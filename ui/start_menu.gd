extends Control
@onready var animation_player = $AnimationPlayer

const GAME = preload("res://scenes/game.tscn")

func _ready():
	play_anim()
	
func play_anim():
	# TODO 
	#animation_player.play(animation_player.get_animation_list().pick_random())
	
	await animation_player.animation_finished
	play_anim()

func _on_new_game_pressed():
	get_tree().change_scene_to_packed(GAME)
