extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	if (actor as CowBase).idle_count % 3 == 0:
		return SUCCESS
	return FAILURE

