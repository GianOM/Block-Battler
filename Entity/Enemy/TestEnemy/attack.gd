extends EnemyAction

@export var damage:= 5

func perform_action():
	if not enemy or not target:
		return
	var tween:= create_tween().set_trans(Tween.TRANS_QUINT)
	var start:= enemy.global_position
	var end:= target.global_position + Vector2.RIGHT * 32
	var damage_effect:= Damage.new()
	damage_effect.amount = damage
	
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func(): COMBATE.enemy_action_completed.emit(enemy)
	)

#func return_description():
	##if not enemy or not target:
		##return
	##description = str(enemy) + "attacks" + str(target)
	##print(description)
	#return description
