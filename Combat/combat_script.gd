extends Node2D


signal Encounter_Enemies_Loaded(List_of_Enemies: Array[Enemy])

@onready var enemy: Enemy = $Enemy
@onready var player: Player = $Player

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
			
			Temp_Node2D.Set_Debug_ID_Text(My_String_Name_ID)
			
		elif Temp_Node2D is Player:
			
			var My_String_Name_ID: String = "P" + str(i)
			Combat_Entities_ID[My_String_Name_ID] = Temp_Node2D
			
			
	Encounter_Enemies_Loaded.emit(Temporary_Enemies)
	
	print(Combat_Entities_ID)
	
	
	
	
func player_turn(actions: Array[String]):
	
	for i in actions:
		
		var action_parameters: PackedStringArray = i.split("-", false)
		
		if i.contains("ATT"):
			
			var target_enemy: Enemy = Combat_Entities_ID[action_parameters[-1]]
			
			if not enemy:
				return
			
			damage.amount = 10
			damage.execute(target_enemy)
			
			
		elif i.contains("DEF"):
			shield.amount = 5
			shield.execute(player)
		
func enemy_turn(actions: Array[String]):
	
	print(actions)
	
	for i in actions:
		if i.contains("ATT"):
			if not player:
				return
			damage.amount = 10
			damage.execute(player)
			
		elif i.contains("DEF"):
			
			if not enemy:
				return
				
			shield.amount = 5
			shield.execute(enemy)
