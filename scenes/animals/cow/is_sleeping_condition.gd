extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if actor.is_sleeping:
		return SUCCESS
	return FAILURE

