extends StateBase

@export var player: Player = null
var speed = 100

func enter():
	super.enter()
	player.machine.travel("Walk")
	
func physical_process_update(delta: float):
	super.physical_process_update(delta)
	if player.direction.length() == 0:
		state_machine.change_state("Idle")
	move()
	
func move():
	player.velocity = player.direction * speed
	player.move_and_slide()
