class_name EnemyManager
extends Node2D

var enemy_list : Array[Enemy]

func _ready() -> void:
	COMBATE.execute_enemy_actions.connect(execute_enemy_actions)
	COMBATE.enemy_action_completed.connect(_on_enemy_action_completed)
	#setup_enemy_list()

func setup_enemies(combat_stats: CombatStats):
	if not combat_stats:
		return
	for enemy in get_children():
		enemy.queue_free()
	var all_new_enemies:= combat_stats.enemies.instantiate()
	for new_enemy in all_new_enemies.get_children():
		var new_enemy_child:= new_enemy.duplicate()
		add_child(new_enemy_child)
		enemy_list.push_back(new_enemy_child)
	all_new_enemies.queue_free()
	

#func setup_enemy_list():
	#for enemy: Enemy in get_children():
		#enemy_list.push_back(enemy)

func setup_enemy_intention(enemy: Enemy, index: int):
	#debug v
	print(enemy.name + ": strength: " + str(enemy.stats.strength))
			
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
	return enemy_intentions

func start_turn():
	
	var Number_of_Enemies_Alive: int = enemy_list.size()
	
	if Number_of_Enemies_Alive == 0:
		#TODO: Emitir algum sinal de notificacao aqui
		return
		
	for i in range(Number_of_Enemies_Alive):
		if enemy_list[i]:
			enemy_list[i].single_enemy_turn()
			break
	
	#enemy_list[0]
	#
	#
	#if get_child_count() == 0:
		#return
	#var first_enemy: Enemy = get_child(0)
	#first_enemy.single_enemy_turn()
	

#func single_enemy_turn():
	#COMBATE.enemy_action_stack.emit()

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
				print(action_node_name)
				Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(j)
				
				
		#var Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(0)
		
		
		var target = COMBATE.Combat_ID_Dict[action_parameters[-1]]
		if not target:
			continue
		Temp_Node.perform_action()
		await Temp_Node.finished_performing_action

		

#func execute_enemy_actions(actions: Array[String]):
	#for i in actions:
		#var action_parameters: PackedStringArray = i.split("-", false)
		#if i.contains("ATT"):
			#var attacking_enemy = COMBATE.Combat_ID_Dict[action_parameters[0]]
			#if not attacking_enemy:
				#continue	
			#var Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(0)
			#var target_player = COMBATE.Combat_ID_Dict[action_parameters[-1]]
			#if not target_player:
				#continue
			#Temp_Node.perform_action()
			#await Temp_Node.finished_performing_action
#
		#elif i.contains("DEF"):
			#var attacking_enemy = COMBATE.Combat_ID_Dict[action_parameters[0]]
			#if not attacking_enemy:
				#continue
			#var Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(1)
			#var target_enemy = COMBATE.Combat_ID_Dict[action_parameters[-1]]
			#
			#if not target_enemy:
				#return
			#
			#Temp_Node.perform_action()
			#await Temp_Node.finished_performing_action
		#
		#elif i.contains("BUFF"):
			#var attacking_enemy = COMBATE.Combat_ID_Dict[action_parameters[0]]
			#if not attacking_enemy:
				#continue
			#var Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(1)
			#var target_enemy = COMBATE.Combat_ID_Dict[action_parameters[-1]]
			#
			#if not target_enemy:
				#return
			#
			#Temp_Node.perform_action()
			#await Temp_Node.finished_performing_action
			
func _on_enemy_action_completed(enemy: Enemy):
	
	var enemy_tree_index: int = enemy.get_index()
	#print(enemy_tree_index)
	
	if enemy_tree_index == get_child_count() - 1:
		COMBATE.enemy_turn_ended.emit()
		return
		
	var next_enemy: Enemy = get_child(enemy_tree_index + 1)
	next_enemy.single_enemy_turn()
