extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if actor.is_just_eating:
		return SUCCESS
	return FAILURE

