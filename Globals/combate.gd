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


@warning_ignore("unused_signal")
signal player_died

@warning_ignore("unused_signal")
signal enemy_action_completed(enemy: Enemy)

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
