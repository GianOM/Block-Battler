extends EnemyAction

@export var shield:= 5

func perform_action():
	if not enemy:
		return
	var shield_effect:= Shield.new()
	shield_effect.amount = shield
	shield_effect.execute(enemy)
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			COMBATE.enemy_action_completed.emit(enemy)
	)
	
