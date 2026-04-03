extends EnemyAction

const VULNERABLE = preload("res://statuses/vulnerable.tres")

@export var duration: int

func perform_action():
	var player_ref: Player = COMBATE.Combat_ID_Dict[enemies_target_id[0]]
	var enemy_self_ref: Enemy = COMBATE.Combat_ID_Dict[self_id]

	if not player_ref and not enemy_self_ref:
		return
	
	var status_effect := StatusEffect.new()
	var vulnerable := VULNERABLE.duplicate()
	vulnerable.duration = duration
	status_effect.status = vulnerable
	status_effect.execute(player_ref)

	
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			COMBATE.enemy_action_completed.emit(enemy_self_ref)
			#finished_performing_action.emit()
	)
	
	
	
func Setup_Action(ID_SELF: String, ID_ALLIED:Array[String], ID_Enemy: Array[String] ) -> void:
	
	
	self_id = ID_SELF
	allies_target_id = ID_ALLIED
	enemies_target_id = ID_Enemy
	

	action_description = ID_SELF + "-" + "Debuff" + "-" + ID_Enemy[0]
	
	
	pass
	
