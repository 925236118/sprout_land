extends Node2D

signal animation_finished

@onready var animation_player = $AnimationPlayer

var animationNames: Array[String] = [
	"SuddenlyAppear"
]

func random_play():
	var random_animation = animationNames.pick_random()
	animation_player.play(random_animation)
	
	await animation_player.animation_finished
	animation_finished.emit()
