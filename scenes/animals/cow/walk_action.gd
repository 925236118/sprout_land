extends ActionLeaf


@onready var beehave_tree = %BeehaveTree
@onready var idle_timer = %IdleTimer

func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	#if not actor.is_full() and not actor.is_just_eating:
		#return FAILURE
	
	actor.move(1.0 / beehave_tree.tick_rate)
	
	if actor.is_idle == false:
		return SUCCESS
		
	return RUNNING

