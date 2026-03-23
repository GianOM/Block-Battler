extends Node2D

var shield = Shield.new()
var damage = Damage.new()

var Combat_Entities_ID: Dictionary = {}

func _ready() -> void:
	
	Load_All_Enemies()
	
	
	COMBATE.execute_player_actions.connect(player_turn)
	COMBATE.execute_enemy_actions.connect(enemy_turn)
	
	
func Load_All_Enemies():
	
	var Temporary_Enemies: Array[Enemy]
	
	for i in range(get_child_count()):
		
		var Temp_Node2D: Node2D = get_child(i)
		
		
		if Temp_Node2D is Enemy:
			
			Temporary_Enemies.push_back(Temp_Node2D)
			
			var My_String_Name_ID: String = "E" + str(i)
			Combat_Entities_ID[My_String_Name_ID] = Temp_Node2D
			Temp_Node2D.Set_Entity_ID(My_String_Name_ID)
			
		elif Temp_Node2D is Player:
			
			var My_String_Name_ID: String = "P" + str(i)
			Combat_Entities_ID[My_String_Name_ID] = Temp_Node2D
			
			
			
			
	COMBATE.Entities_ID_Loaded.emit(Combat_Entities_ID)
	#Entities_ID_Loaded.emit(Combat_Entities_ID)
	
	print(Combat_Entities_ID)
	
	
	
	
func player_turn(actions: Array[String]):
	
	for i in actions:
		
		var action_parameters: PackedStringArray = i.split("-", false)
		
		if i.contains("ATT"):
			
			var target_enemy: Enemy = Combat_Entities_ID[action_parameters[-1]]
			
			if not target_enemy:
				return
			
			
			damage.amount = 10
			damage.execute(target_enemy)
			
			
		elif i.contains("DEF"):
			
			
			
			var target_player: Player = Combat_Entities_ID[action_parameters[-1]]
			
			if not target_player:
				return
			
			
			shield.amount = 5
			shield.execute(target_player)
		
func enemy_turn(actions: Array[String]):
	
	print(actions)
	
	for i in actions:
		
		var action_parameters: PackedStringArray = i.split("-", false)
		
		if i.contains("ATT"):
			var target_player: Player = Combat_Entities_ID[action_parameters[-1]]
			
			if not target_player:
				return
				
			damage.amount = 10
			damage.execute(target_player)
			
		elif i.contains("DEF"):
			
			var target_enemy: Enemy = Combat_Entities_ID[action_parameters[-1]]
			
			if not target_enemy:
				return
				
			shield.amount = 5
			shield.execute(target_enemy)
