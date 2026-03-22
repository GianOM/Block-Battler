extends VBoxContainer



## Adiciona os labels que serao traduzidos em Instrucoes
func enemy_intention(turn: int, enemy_stats: EnemyStats):
	if turn >= enemy_stats.attack_pattern.size():
		
		turn %= enemy_stats.attack_pattern.size()
		
	for i in enemy_stats.attack_pattern.size():
		
		if i == turn:
			
			var Temp_Label: Label = Label.new()
			
			Temp_Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
			
			Temp_Label.text = enemy_stats.attack_pattern[i]
			
			add_child(Temp_Label)
			
			
			
func Clear_All_Instructions():
	
	while get_child_count() > 0:
		
		get_child(0).queue_free()
		await get_tree().process_frame
		
	
