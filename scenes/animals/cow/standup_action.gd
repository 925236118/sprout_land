extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	actor = actor as CowBase
	if actor.animation_player.assigned_animation == "Standup" and  not actor.animation_player.is_playing():
		return SUCCESS
		
	actor.stand
	return RUNNING

