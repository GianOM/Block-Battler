extends Node

var Combat_ID_Dict: Dictionary = {}

@warning_ignore("unused_signal")
signal Entities_ID_Loaded(List_of_Entities: Dictionary)


#region start of player turn

@warning_ignore("unused_signal")
signal Load_Player_FBlocks(FBlocks_Root_Node: Node)

@warning_ignore("unused_signal")
signal load_enemy_intentions_requested(turn: int)

@warning_ignore("unused_signal")
signal execute_player_turn
@warning_ignore("unused_signal")
signal player_action_stack

@warning_ignore("unused_signal")
signal execute_player_actions(actions: Array[String])

@warning_ignore("unused_signal")
signal player_turn_ended
#endregion

#region enemy turn
@warning_ignore("unused_signal")
signal enemy_action_stack
@warning_ignore("unused_signal")
signal execute_enemy_actions(actions: Array[String])
@warning_ignore("unused_signal")
signal enemy_turn_ended
@warning_ignore("unused_signal")
signal enemy_action_completed(enemy: Enemy)
#endregion

#region combat stuff
@warning_ignore("unused_signal")
signal player_died
@warning_ignore("unused_signal")
signal end_of_combat_screen_requested(text: String, type: EndOfCombatPanel.Type)
signal combat_won
#endregion


@warning_ignore("unused_signal")
signal ToolTip_Requested(Block_info: Universal_Block)



# Perharps move this to inside the Entity Code?
func shake(thing: Node2D, strength: float, duration: float = 0.2):
	if not thing:
		return
	var origin:= thing.position
	var shake_count:= 10
	var tween:= create_tween()
	
	for i in shake_count:
		var shake_offset:= Vector2(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))
		var target:= origin + strength * shake_offset
		if i % 2 == 0:
			target = origin
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75
	tween.finished.connect(func(): thing.position = origin)
