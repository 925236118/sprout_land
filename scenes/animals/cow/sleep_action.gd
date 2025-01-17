extends ActionLeaf

@onready var sleep_timer = %SleepTimer

func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	actor.sleep()
	
	if sleep_timer.time_left == 0:
		return SUCCESS
		
	return RUNNING
