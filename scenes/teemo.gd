extends CharacterBody2D
@onready var animation_player = $AnimationPlayer

enum State {
	Idle,
	Walk,
}

var speed = 100
var direction = Vector2.DOWN
var animation_direction: String = "down"
func _ready() -> void:
	pass

func get_next_state(state: State) -> State:
	match state:
		State.Walk:
			if direction.length() == 0:
				return State.Idle
		State.Idle:
			if direction.length() > 0:
				return State.Walk
	return state
	
func tick_physics(state:State, _delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var next_animation_direction = ""
	if direction.y != 0:
		next_animation_direction = "down" if direction.y > 0 else "up"
	elif direction.x != 0:
		next_animation_direction = "right" if direction.x > 0 else "left"
	
	if next_animation_direction != "" and next_animation_direction != animation_direction:
		animation_direction = next_animation_direction
		transition_state(state, state)
	match state:
		State.Walk:
			move()

func transition_state(from: State, to: State) -> void:
	#print("state from {0}, to {1}".format([from, to]))
	match to:
		State.Walk:
			animation_player.play("walk_" + animation_direction)
		State.Idle:
			animation_player.play("idle_" + animation_direction)
func move():
	velocity = direction * speed
	move_and_slide()
