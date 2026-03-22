extends Control

@export var character_stats: CharacterStats

#TODO for now the enemy resource will be set here
#later when encounters are randomized, idk yet
@export var enemy_stats: EnemyStats

var List_of_Enemies: Array[Enemy]

@onready var combat_manager: Node = $CombatManager
@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern
@onready var list_of_player_instructions: VBoxContainer = %List_of_Player_Instructions
@onready var turn_ready_button: Button = $Turn_Ready_Button
@onready var turn_label: Label = $TurnLabel

var turn_count := 0

func _on_list_of_enemies_set(encounter_list_of_enemies: Array[Enemy]):
	List_of_Enemies = encounter_list_of_enemies
	
	Load_All_Enemies_Intentions(List_of_Enemies)
	
	
func Load_All_Enemies_Intentions(encounter_list_of_enemies: Array[Enemy]):
	
	for individual_enemy in encounter_list_of_enemies:
		
		# Como os inimigos sao inicializados no _ready(), a referencia @onready 
		# ainda é nula, logo, precisamos da referencia direta
		
		if individual_enemy != null:
			%EnemyAttackPattern.enemy_intention(turn_count, individual_enemy.stats)
	


func _ready() -> void:
	#temp
	var new_stats = character_stats.create_instance()
	#combat_manager.character_stats = new_stats
	#
	var new_enemy = enemy_stats.create_instance()
	#combat_manager.enemy_stats = new_enemy
	
	#start_combat(new_stats)

func start_combat(stats: CharacterStats):
	#temp
	enemy_attack_pattern.enemy_intention(turn_count, enemy_stats)
	
func _on_turn_ready_button_pressed() -> void:
	turn_ready_button.hide()
	player_turn()
	turn_count += 1
	
	await get_tree().create_timer(2.0).timeout

	enemy_turn()
	turn_ready_button.show()

func player_turn():
	turn_label.text = "Player Turn"
	turn_label.show()
	
	var player_actions : Array[String]
	for i in range(list_of_player_instructions.get_child_count()):
		player_actions.push_back(list_of_player_instructions.get_child(i).text)
	COMBATE.execute_player_actions.emit(player_actions)
	
	for i in range(list_of_player_instructions.get_child_count()):
		list_of_player_instructions.get_child(i).queue_free()
		
	await get_tree().create_timer(1.0).timeout
	
	turn_label.hide()
	
	COMBATE.finished_executing_player_actions.emit()
	
	
func enemy_turn():
	turn_label.text = "Enemy Turn"
	turn_label.show()
	
	
	#Load_All_Enemies_Intentions(List_of_Enemies)
	
	var enemy_actions: Array[String]
	for i in range(enemy_attack_pattern.get_child_count()):
		enemy_actions.push_back(enemy_attack_pattern.get_child(i).text)
		
		
	COMBATE.execute_enemy_actions.emit(enemy_actions)
	
	enemy_attack_pattern.Clear_All_Instructions()
	
	
	await get_tree().create_timer(1.0).timeout
	
	
	
	#enemy_attack_pattern.Clear_All_Instructions()
	
	
	Load_All_Enemies_Intentions(List_of_Enemies)
	
	
	turn_label.hide()
	
	
	COMBATE.finished_executing_enemy_actions.emit()
	
