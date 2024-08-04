class_name CowBase extends CharacterBody2D
@onready var cow_body = $CowBody

@onready var eating_cooldown_timer = $EatingCooldownTimer
@onready var animation_player = $AnimationPlayer
@onready var idle_timer = $IdleTimer

@onready var forword_cast = $CowBody/ForwordCast
@onready var up_cast = $CowBody/UpCast
@onready var down_cast = $CowBody/DownCast

## 牛 饿了吃草，吃完草散步，偶尔睡觉

@export var max_full_progress: int = 100

# 饱食度
var full_progress: int = 0
# 吃饭冷却
var is_just_eating: bool = false
# 是否在坐着
var is_siting: bool = false
# 是否在睡觉
var is_sleeping: bool = false
# 移动方向
var direction = Vector2.RIGHT
# 移动速度
var speed: int = 10
# 当前是否在休息中
var is_idle = false

func change_direction():
	direction = Vector2(randf() * 2 - 1.0, randf() * 2 - 1.0).normalized()
	if direction.x < 0:
		cow_body.scale.x = -1
	else:
		cow_body.scale.x = 1

func is_full() -> bool:
	return full_progress == max_full_progress

func move(delta: float):
	if forword_cast.get_collider() != null or up_cast.get_collider() != null or down_cast.get_collider() != null:
		change_direction()
	velocity = direction * speed * delta
	move_and_slide()
	if not animation_player.is_playing() or animation_player.assigned_animation != "Walk":
		#print("walk")
		animation_player.play("Walk")
		is_idle = true
		idle_timer.wait_time = randi_range(2, 5)
		idle_timer.start()

func idle():
	var idle_animation_names = ["SitIdle","SitIdle2","Idle","Idle2"]
	if animation_player.is_playing() and idle_animation_names.has(animation_player.assigned_animation):
		return
	
	var random = randf()
	is_idle = true
	
	if is_siting:
		if random < 0.6:
			animation_player.play("SitIdle")
		else:
			animation_player.play("SitIdle2")
	else:
		if random < 0.6:
			animation_player.play("Idle")
		else:
			animation_player.play("Idle2")
	await animation_player.animation_finished
	idle_timer.wait_time = randi_range(2, 5)
	idle_timer.start()

func sleep():
	#print("sleep")
	idle_timer.start()
	is_idle = true
	if not is_siting:
		animation_player.play("Sitdown")
		await animation_player.animation_finished
	if not animation_player.is_playing() or animation_player.assigned_animation != "Sleeping":
		animation_player.play("Sleeping")

func _on_eating_cooldown_timer_timeout():
	#print("eat timer end")
	is_just_eating = false

func eat_gress():
	is_idle = false
	if animation_player.assigned_animation == "EatGrass" and animation_player.is_playing():
		return
	#print("eating grass")
	animation_player.play("EatGrass")
	full_progress = clamp(full_progress + 20, 0, max_full_progress)
	await animation_player.animation_finished
	is_just_eating = true
	eating_cooldown_timer.start()
	


func _on_idle_timer_timeout():
	#print('idle timer end')
	is_idle = false
