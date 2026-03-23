extends Node




var Combat_ID_Dict: Dictionary = {}


@warning_ignore("unused_signal")
signal Entities_ID_Loaded(List_of_Entities: Dictionary)






@warning_ignore("unused_signal")
signal execute_player_actions(actions: Array[String])
@warning_ignore("unused_signal")
signal finished_executing_player_actions

@warning_ignore("unused_signal")
signal execute_enemy_actions(actions: Array[String])
@warning_ignore("unused_signal")
signal finished_executing_enemy_actions


#@warning_ignore("unused_signal")
#signal player_turn_ended

@warning_ignore("unused_signal")
signal enemy_action_completed(enemy: Enemy)
