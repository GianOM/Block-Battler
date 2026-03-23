extends VBoxContainer

### Adiciona os labels que serao traduzidos em Instrucoes
#func enemy_intention(turn: int, enemy_stats: EnemyStats):
	#
	#if turn >= enemy_stats.attack_pattern.size():
		#
		#turn %= enemy_stats.attack_pattern.size()
		#
	#for i in enemy_stats.attack_pattern.size():
		#
		#if i == turn:
			#
			#var Temp_Label: Label = Label.new()
			#
			#Temp_Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
			#
			#Temp_Label.text = enemy_stats.attack_pattern[i]
			#
			#add_child(Temp_Label)
			
func enemy_intention(turn: int, enemy: Enemy):
	var enemy_actions: Array[EnemyAction] = enemy.Attack_Pattern_Node.load_actions()
	#var instanced_action_scene = enemy.stats.action_scene.instantiate()
	if turn >= enemy_actions.size():
		turn %= enemy_actions.size()
	for i in enemy_actions.size():
		if i == turn:
			var label:= Label.new()
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
			
			var new_text = enemy_actions[i].return_description()
			label.text = new_text
			
			add_child(label)

func Clear_All_Instructions():
	
	while get_child_count() > 0:
		
		get_child(0).queue_free()
		await get_tree().process_frame
		
	
