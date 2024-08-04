extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	if (actor as CowBase).is_siting:
		return SUCCESS
	return FAILURE

