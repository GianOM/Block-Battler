extends VBoxContainer

var enemy_manager_ref: EnemyManager

func _ready() -> void:
	COMBATE.load_enemy_intentions_requested.connect(write_enemy_intentions)


func write_enemy_intentions(turn: int):
	var enemy_list = enemy_manager_ref.get_children()
	
	for enemy in enemy_list:
		if not enemy:
			return
		write_single_enemy_intention(enemy, turn)
			
func write_single_enemy_intention(enemy: Enemy, counter: int):
	
	var enemy_actions: Array[String] = enemy_manager_ref.return_intentions_for_single_enemy(enemy)
	if counter >= enemy_actions.size():
		counter %= enemy_actions.size()
	for i in enemy_actions.size():
		if i == counter:
			enemy_manager_ref.setup_enemy_intention(enemy, i)
			var label:= Label.new()
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
			label.text = enemy_actions[i]
			add_child(label)
	
func Clear_All_Instructions():
	
	for i in get_child_count():
		get_child(i).queue_free()
		
	
