extends EnemyAction

@export var shield:= 5

#func perform_action():
	#if not enemy:
		#return
	#var shield_effect:= Shield.new()
	#shield_effect.amount = shield
	#shield_effect.execute(enemy)
	#
	#get_tree().create_timer(0.6, false).timeout.connect(
		#func():
			#COMBATE.enemy_action_completed.emit(enemy)
	#)
	
	
	
@warning_ignore("unused_parameter")
func Setup_Action(ID_SELF: String, ID_ALLIED:Array[String], ID_Enemy: Array[String] ) -> void:
	
	
	self_id = ID_SELF
	allies_target_id = ID_ALLIED
	enemies_target_id = ID_Enemy
	
	
	
	
	action_description = ID_SELF + "-" + "DEF" + "-" + ID_ALLIED[0]
	
	#
	#
	#
	#
#func Setup_Action() -> void:
	#description = "E2-DEF-E3"
