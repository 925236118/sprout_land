extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if actor.animation_player.assigned_animation == "EatGrass" and not actor.animation_player.is_playing():
		return SUCCESS
	actor.eat_gress()
	return RUNNING
