class_name StateMachine
extends Node

var currenrt_state: int = -1:
	set(v):
		owner.transition_state(currenrt_state, v)
		currenrt_state = v
		state_time = 0

var state_time: float

func _ready() -> void:
	await owner.ready
	currenrt_state = 0

func _physics_process(delta: float) -> void:
	while true:
		var next := owner.get_next_state(currenrt_state) as int
		if currenrt_state == next:
			break
		currenrt_state = next
		
	owner.tick_physics(currenrt_state, delta)
	state_time += delta
