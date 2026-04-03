class_name EnemyManager
extends Node2D

var enemy_list : Array[Enemy]
var acting_enemies: Array[Enemy]

func _ready() -> void:
	COMBATE.enemy_died.connect(_on_enemy_died)
	#COMBATE.execute_enemy_actions.connect(execute_enemy_actions)
	COMBATE.enemy_action_completed.connect(_on_enemy_action_completed)

func setup_enemies(combat_stats: CombatStats):
	if not combat_stats:
		return
	for enemy in get_children():
		enemy.queue_free()
	var all_new_enemies:= combat_stats.enemies.instantiate()
	for new_enemy in all_new_enemies.get_children():
		var new_enemy_child:= new_enemy.duplicate()
		add_child(new_enemy_child)
		new_enemy_child.status_manager.statuses_applied.connect(_on_enemy_statuses_applied.bind(new_enemy_child))
		enemy_list.push_back(new_enemy_child)
	all_new_enemies.queue_free()
	

func setup_enemy_intention(enemy: Enemy, index: int):
	#debug v
	#print(enemy.name + ": strength: " + str(enemy.stats.strength))
			
	var enemy_actions: Array[EnemyAction] = enemy.Attack_Pattern_Node.load_actions()
	enemy.set_intent_ui(enemy_actions[index])

#returns a single enemy's intentions as array of strings for the UI to use
func return_intentions_for_single_enemy(enemy: Enemy) -> Array[String]:
	var enemy_intentions: Array[String]
	var enemy_actions: Array[EnemyAction] = enemy.Attack_Pattern_Node.load_actions()
	for i in enemy_actions.size():
		#enemy.set_intent_ui(enemy_actions[i])
		var new_text = enemy_actions[i].return_description()
		enemy_intentions.push_back(new_text)
	#print(enemy_intentions)
	return enemy_intentions


func execute_enemy_actions(actions: Array[String]):
	for i in actions:
		var action_parameters: PackedStringArray = i.split("-", false)
		var Temp_Node
		var attacking_enemy = COMBATE.Combat_ID_Dict[action_parameters[0]]
		if not attacking_enemy:
			continue	
		for j in attacking_enemy.Attack_Pattern_Node.get_child_count():
			var action_node_name = attacking_enemy.Attack_Pattern_Node.get_child(j).name
			if i.contains(action_node_name):
				#print(action_node_name)
				Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(j)
				
				
		#var Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(0)
		
		
		var target = COMBATE.Combat_ID_Dict[action_parameters[-1]]
		if not target:
			continue
		Temp_Node.perform_action()
		await Temp_Node.finished_performing_action

func start_turn():
	if get_child_count() == 0:
		return
	
	acting_enemies.clear()
	for enemy: Enemy in get_children():
		acting_enemies.push_back(enemy)
	_start_next_enemy_turn()
	

	#var Number_of_Enemies_Alive: int = enemy_list.size()
	#
	#if Number_of_Enemies_Alive == 0:
		##TODO: Emitir algum sinal de notificacao aqui
		#return
		#
	#for i in range(Number_of_Enemies_Alive):
		#if enemy_list[i]:
			#enemy_list[i].single_enemy_turn()
			#break

func _start_next_enemy_turn():
	if acting_enemies.is_empty():
		COMBATE.enemy_turn_ended.emit()
		
		return
	

	acting_enemies[0].status_manager.apply_statuses_by_type(Status.Type.START_OF_TURN)
	
	
func _on_enemy_statuses_applied(type: Status.Type, enemy: Enemy):
	match type:
		Status.Type.START_OF_TURN:
			enemy.do_enemy_turn()
		Status.Type.END_OF_TURN:
			
			acting_enemies.erase(enemy)
			_start_next_enemy_turn()

func _on_enemy_died(enemy: Enemy):
	var is_enemy_turn:= acting_enemies.size() > 0
	acting_enemies.erase(enemy)
	
	if is_enemy_turn:
		_start_next_enemy_turn()

func _on_enemy_action_completed(enemy: Enemy):
	#print("enemy action completed")
	enemy.status_manager.apply_statuses_by_type(Status.Type.END_OF_TURN)
	#var enemy_tree_index: int = enemy.get_index()
	#
	#if enemy_tree_index == get_child_count() - 1:
		#COMBATE.enemy_turn_ended.emit()
		#return
		#
	#var next_enemy: Enemy = get_child(enemy_tree_index + 1)
	#next_enemy.single_enemy_turn()
