extends EnemyAction

@export var damage:= 5

func perform_action():
	
	var player_ref: Player = COMBATE.Combat_ID_Dict[enemies_target_id[0]]
	var enemy_self_ref: Enemy = COMBATE.Combat_ID_Dict[self_id]
	
	
	if not player_ref:
		return
		
	
	
		
	var tween:= create_tween().set_trans(Tween.TRANS_QUINT)
	var start:= enemy_self_ref.global_position
	var end:= player_ref.global_position + Vector2.RIGHT * 32
	var damage_effect:= Damage.new()
	damage_effect.amount = damage
	
	tween.tween_property(enemy_self_ref, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(player_ref))
	tween.tween_interval(0.25)
	tween.tween_property(enemy_self_ref, "global_position", start, 0.4)
	
	tween.finished.connect(
		func(): 
			COMBATE.enemy_action_completed.emit(enemy_self_ref)
			finished_performing_action.emit()
	)
	
@warning_ignore("unused_parameter")
func Setup_Action(ID_SELF: String, ID_ALLIED:Array[String], ID_Enemy: Array[String] ) -> void:
	
	
	self_id = ID_SELF
	allies_target_id = ID_ALLIED
	enemies_target_id = ID_Enemy
	
	
	
	
	
	
	action_description = ID_SELF + "-" + "ATT" + "-" + ID_Enemy[0]
	
	
	pass



#func return_description():
	##if not enemy or not target:
		##return
	##description = str(enemy) + "attacks" + str(target)
	##print(description)
	#return description
