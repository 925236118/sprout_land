extends ActionLeaf

@onready var idle_timer = %IdleTimer

func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if not actor.is_full() and not actor.is_just_eating:
		return FAILURE
	
	if idle_timer.get_time_left() == 0:
		return SUCCESS
	actor.sleep()
	return RUNNING

