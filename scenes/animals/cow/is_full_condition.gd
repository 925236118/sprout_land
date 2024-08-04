extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if actor.full_progress == actor.max_full_progress:
		return SUCCESS
	return FAILURE

