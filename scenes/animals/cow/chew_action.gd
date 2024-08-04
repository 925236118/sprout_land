extends ActionLeaf

@onready var chew_timer = %ChewTimer

func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	
	actor.chewing()
	
	if chew_timer.time_left == 0:
		return SUCCESS
		
	return RUNNING

