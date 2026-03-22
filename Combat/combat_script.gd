extends Node2D


signal Encounter_Enemies_Loaded(List_of_Enemies: Array[Enemy])

@onready var enemy: Enemy = $Enemy
@onready var player: Player = $Player

var shield = Shield.new()
var damage = Damage.new()

func _ready() -> void:
	
	#shield.amount = 300
	#shield.execute(entity)
	
	
	Load_All_Enemies()
	
	
	COMBATE.execute_player_actions.connect(player_turn)
	COMBATE.execute_enemy_actions.connect(enemy_turn)
	
	
func Load_All_Enemies():
	
	var Temporary_Enemies: Array[Enemy]
	
	for i in range(get_child_count()):
		
		var Temp_Node2D: Node2D = get_child(i)
		
		if Temp_Node2D is Enemy:
			Temporary_Enemies.push_back(Temp_Node2D)
			
	Encounter_Enemies_Loaded.emit(Temporary_Enemies)
			
	
	
	
func player_turn(actions: Array[String]):
	
	for i in actions:
		if i.contains("ATT"):
			if not enemy:
				return
			
			damage.amount = 10
			damage.execute(enemy)
			
			
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
