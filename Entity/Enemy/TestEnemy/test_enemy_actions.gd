extends Node

var Self_Entity_ID: String
var Attack_Target_ID: Array[String]
var Defend_Target_ID: Array[String]

func Set_Self_ID(input_self_ID: String):
	Self_Entity_ID = input_self_ID
		
		
func _ready() -> void:
	COMBATE.Entities_ID_Loaded.connect(_on_entities_id_loaded)
		
		
		
		
func _on_entities_id_loaded(encounter_list_of_enemies: Dictionary):
	
	for entity_id in encounter_list_of_enemies:
		
		if entity_id == Self_Entity_ID:
			continue
			
		if encounter_list_of_enemies[entity_id] is Enemy:
			Defend_Target_ID.push_back(entity_id)
		elif encounter_list_of_enemies[entity_id] is Player:
			Attack_Target_ID.push_back(entity_id)
	
	
	
	for i in range(get_child_count()):
		var Node_Action: EnemyAction = get_child(i)
		Node_Action.Setup_Action(Self_Entity_ID, Defend_Target_ID, Attack_Target_ID)
		
		
		
func load_actions() -> Array[EnemyAction]:
	
	var Temp_Enemy_Action: Array[EnemyAction]
	
	
	for i in range(get_child_count()):
		
		Temp_Enemy_Action.push_back(get_child(i))
		
	return Temp_Enemy_Action
		
		
		
		
