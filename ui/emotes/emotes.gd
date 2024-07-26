class_name Emotes extends Node2D

signal animation_finished
signal random_play_finished

@onready var animation_player = $AnimationPlayer

var animationNames: Array[String] = [
	"Appear",
	"Leave",
	"MoveEars",
	"Blink",
	"Like",
	
	"Laugh",
	"LaughWithCloseEyes",
	
	"Cool",
	"CoolWhthShine",
	"CoolWithSmile",
	
	"Angry",
	"AngryTalk",
	
	"Embarrass",
	
	"Sleepy",
	"Sleeping",
	"SleepingWithWave",
	"WakeUp",
	
	"FallinDeepSleep",
	"DeepSleeping",
	"AwakeFromDeepSleeping",
	
	"FallinDeepSleepWithBubble",
	"DeepSleepingWithBubble",
	"AwakeFromDeepSleepingWithBubble",
]

func random_play():
	var random = randf()
	if random < 0.1:
		#print("laugh")
		laugh()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.2:
		#print("embarrass")
		embarrass()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.3:
		#print("happy_jump")
		happy_jump()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.4:
		#print("cool")
		cool()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.5:
		#print("cool_with_shine")
		cool_with_shine()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.6:
		#print("cool_with_smile")
		cool_with_smile()
		await animation_finished
		random_play_finished.emit()
		pass
	elif random < 0.7:
		#print("leave and appear")
		leave()
		await animation_finished
		await get_tree().create_timer(randf_range(3.0, 6.0)).timeout
		appear()
		await animation_finished
		await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
		random_play_finished.emit()
		pass
	elif random < 0.8:
		#print("deep_sleep_with_bubble")
		deep_sleep_with_bubble()
		await animation_finished
		random_play_finished.emit()
	elif random < 0.9:
		#print("sleep")
		sleep()
		await animation_finished
		random_play_finished.emit()
	else:
		random_play()

func appear():
	animation_player.play("Appear")
	await animation_player.animation_finished
	animation_finished.emit()

func leave():
	animation_player.play("Leave")
	await animation_player.animation_finished
	animation_finished.emit()
	
func laugh():
	animation_player.play("Laugh")
	await animation_player.animation_finished
	animation_finished.emit()
	
func happy_jump():
	animation_player.play("HappyJump")
	await animation_player.animation_finished
	animation_finished.emit()	
	
func embarrass():
	animation_player.play("Embarrass")
	await animation_player.animation_finished
	animation_finished.emit()
	
func cool():
	animation_player.play("Cool")
	await animation_player.animation_finished
	animation_finished.emit()
	
func cool_with_shine():
	animation_player.play("CoolWhthShine")
	await animation_player.animation_finished
	animation_finished.emit()
	
func cool_with_smile():
	animation_player.play("CoolWithSmile")
	await animation_player.animation_finished
	animation_finished.emit()
	
func sleep():
	animation_player.play("Sleepy")
	await animation_player.animation_finished
	
	var sleep_random = randf()
	
	if sleep_random < 0.6:
		for i in randi_range(1, 3):
			animation_player.play("Sleeping")
			await animation_player.animation_finished
	else:
		for i in randi_range(1, 3):
			animation_player.play("SleepingWithWave")
			await animation_player.animation_finished
	
	animation_player.play("WakeUp")
	await animation_player.animation_finished
	animation_finished.emit()
	
func deep_sleep():
	animation_player.play("FallinDeepSleep")
	await animation_player.animation_finished
	
	for i in randi_range(1, 3):
		animation_player.play("DeepSleeping")
		await animation_player.animation_finished
	
	animation_player.play("AwakeFromDeepSleeping")
	await animation_player.animation_finished
	
	animation_finished.emit()
	
func deep_sleep_with_bubble():
	animation_player.play("FallinDeepSleepWithBubble")
	await animation_player.animation_finished
	
	for i in randi_range(1, 3):
		animation_player.play("DeepSleepingWithBubble")
		await animation_player.animation_finished
	
	animation_player.play("AwakeFromDeepSleepingWithBubble")
	await animation_player.animation_finished
	
	animation_finished.emit()
	
