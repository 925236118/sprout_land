extends ConditionLeaf

func tick(actor, blackboard: Blackboard):
	if (actor as CowBase).is_chewing:
		return SUCCESS
	return FAILURE
