extends Node

var Combat_ID_Dict: Dictionary = {}

@warning_ignore("unused_signal")
signal Entities_ID_Loaded(List_of_Entities: Dictionary)


#start of player turn
signal load_enemy_intentions_requested(turn: int)
signal execute_player_turn
signal player_action_stack
signal execute_player_actions(actions: Array[String])
signal player_turn_ended

#enemy turn
signal enemy_action_stack
signal execute_enemy_actions(actions: Array[String])
signal enemy_turn_ended
signal enemy_action_completed(enemy: Enemy)

#combat stuff
signal player_died
signal end_of_combat_screen_requested(text: String, type: EndOfCombatPanel.Type)




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
