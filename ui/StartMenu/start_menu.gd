extends Control

@onready var emotes: Emotes = %Emotes

const FARM = preload("res://scenes/farm.tscn")

func _ready():
	emotes.appear()
	await emotes.animation_finished
	random_animation()

func random_animation():
	var random = randf()
	if random < 0.7:
		#print("wait")
		if get_tree() != null:
			await get_tree().create_timer(3).timeout
	else:
		emotes.random_play()
		await emotes.random_play_finished
		if get_tree() != null:
			await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
		
	random_animation()

func _on_new_game_pressed():
	emotes.leave()
	await emotes.animation_finished
	get_tree().change_scene_to_packed(FARM)
