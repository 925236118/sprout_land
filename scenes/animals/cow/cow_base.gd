class_name CowBase extends CharacterBody2D

## 牛 饿了吃草，吃完草散步，偶尔睡觉

#region export values

@export_range(1, 20, 0.5) var min_sleep_time: float = 10
@export_range(1, 20, 0.5) var max_sleep_time: float = 15
@export_range(1, 20, 0.5) var min_chew_time: float = 8
@export_range(1, 20, 0.5) var max_chew_time: float = 15
@export_range(1, 10, 0.5) var min_idle_time: float = 2
@export_range(1, 10, 0.5) var max_idle_time: float = 5
@export_range(10, 60, 1) var min_eat_cooldown_time: float = 30
@export_range(10, 60, 1) var max_eat_cooldown_time: float = 40
@export var max_full_progress: int = 100

#endregion

#region nodes

# cow body texture
@onready var cow_body = $CowBody

# animation
@onready var animation_player = $AnimationPlayer

# timer
@onready var eating_cooldown_timer = %EatingCooldownTimer
@onready var idle_timer = %IdleTimer
@onready var sleep_timer = %SleepTimer
@onready var chew_timer = %ChewTimer

# raycast
@onready var forword_cast = $CowBody/ForwordCast
@onready var up_cast = $CowBody/UpCast
@onready var down_cast = $CowBody/DownCast

#endregion

#region define values
# 饱食度
var full_progress: int = 0
# 吃饭冷却
var is_just_eating: bool = false
# 拒绝中
var is_chewing: bool = false
# 是否在坐着
var is_siting: bool = false
# 是否在睡觉
var is_sleeping: bool = false
# 移动方向
var direction = Vector2.RIGHT
# 移动速度
var speed: int = 10
# 当前是否在休息中（休息和散步都为休息）
var is_idle: bool = false
# 计算每次睡觉间隔的idle次数
var idle_count: int = 1
# 每次睡觉间隔的idle次数
var sleep_interval_idle_count: int = 10

#endregion

#region condition functions

# 检查是否饱食
func is_full() -> bool:
	return full_progress == max_full_progress

#endregion

#region action functions
# 移动
func move(delta: float):
	if forword_cast.get_collider() != null or up_cast.get_collider() != null or down_cast.get_collider() != null:
		change_direction()
	velocity = direction * speed * delta
	move_and_slide()
	if not animation_player.is_playing() or animation_player.assigned_animation != "Walk":
		#print("walk")
		animation_player.play("Walk")
		is_idle = true
		idle_timer.wait_time = randi_range(min_idle_time, max_idle_time)
		idle_timer.start()

# 修改移动方向
func change_direction():
	direction = Vector2(randf() * 2 - 1.0, randf() * 2 - 1.0).normalized()
	if direction.x < 0:
		cow_body.scale.x = -1
	else:
		cow_body.scale.x = 1

# 休息
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
	idle_timer.wait_time = randi_range(min_idle_time, max_idle_time)
	idle_timer.start()

# 睡觉
func sleep():
	if sleep_timer.time_left == 0:
		sleep_timer.wait_time = randf_range(min_sleep_time, max_sleep_time)
		sleep_timer.start()
		# 如果设置成0会导致每次取余必定为0
		idle_count = 1
	
	#print(sleep_timer.time_left)
	if not is_siting:
		animation_player.play("Sitdown")
		await animation_player.animation_finished
		is_siting = true
	if animation_player.is_playing() and animation_player.assigned_animation == "Sleeping":
		return
	animation_player.play("Sleeping")
	is_sleeping = true

# 吃草
func eat_gress():
	is_idle = false
	if animation_player.assigned_animation == "EatGrass" and animation_player.is_playing():
		return
	#print("eating grass")
	animation_player.play("EatGrass")
	full_progress = clamp(full_progress + randf_range(10, 20), 0, max_full_progress)
	await animation_player.animation_finished
	is_just_eating = true
	is_chewing = true
	eating_cooldown_timer.wait_time = randf_range(min_eat_cooldown_time, max_eat_cooldown_time)
	eating_cooldown_timer.start()
	
func standup():
	if animation_player.assigned_animation == "Standup" and animation_player.is_playing():
		return
	animation_player.play("Standup")
	is_sleeping = false

func chewing():
	if animation_player.assigned_animation == "Chewing" and animation_player.is_playing():
		return
	if chew_timer.time_left == 0:
		chew_timer.wait_time = randf_range(min_chew_time, max_chew_time)
		chew_timer.start()
	animation_player.play("Chewing")
	is_chewing = true
#endregion

#region timer timeout

func _on_eating_cooldown_timer_timeout():
	is_just_eating = false

func _on_idle_timer_timeout():
	is_idle = false
	idle_count += 1
	print("idle_count ", idle_count)


func _on_sleep_timer_timeout():
	is_sleeping = false

func _on_chew_timer_timeout():
	print("chew timer end")
	is_chewing = false

#endregion
