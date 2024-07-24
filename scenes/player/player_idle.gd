extends StateBase

#@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@export var player: Player = null

func enter():
	super.enter()
	player.machine.travel("Idle")
	#animation_player.play("idle_down")

func physical_process_update(delta: float):
	super.physical_process_update(delta)
	if Input.is_action_just_pressed("tool"):
		state_machine.change_state("UseTool")
	if player.direction.length() != 0:
		state_machine.change_state("Walk")
