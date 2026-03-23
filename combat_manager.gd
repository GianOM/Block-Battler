class_name CombatManager
extends Node

@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern
@onready var list_of_player_instructions: VBoxContainer = %List_of_Player_Instructions
@onready var turn_ready_button: Button = $"../Turn_Ready_Button"
@onready var turn_label: Label = $"../TurnLabel"

var character: CharacterStats
var List_of_Enemies: Array[Enemy]
var turn_count := 0


func _ready() -> void:
	COMBATE.Entities_ID_Loaded.connect(_on_list_of_enemies_set)

func _on_list_of_enemies_set(encounter_list_of_enemies: Dictionary):
	
	for entity in encounter_list_of_enemies.values():
		
		if entity is Enemy:
			List_of_Enemies.push_back(entity)
		

	
func load_enemy_intentions(enemies: Array[Enemy]):
	for enemy in enemies:
		if enemy:
			enemy_attack_pattern.enemy_intention(turn_count, enemy)

func start_battle(character_stats: CharacterStats):
	character = character_stats
	#enemy_attack_pattern.enemy_intention(turn_count, enemy_stats)
	#TBD anything else that needs to happen at the start of combat
	#e.g. duplicating the block pools if necessary etc
	start_turn()

func start_turn():
	load_enemy_intentions(List_of_Enemies)
	character.shield = 0
	#TBD reset energy or whatever

#AKA end turn
func _on_turn_ready_button_pressed() -> void:
	turn_ready_button.hide()
	execute_player_actions()
	turn_count += 1
	
	#temp
	await get_tree().create_timer(2.0).timeout

	execute_enemy_actions()
	turn_ready_button.show()
	start_turn()

func execute_player_actions():
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
	
	
func execute_enemy_actions():
	turn_label.text = "Enemy Turn"
	turn_label.show()
	
	
	var enemy_actions: Array[String]
	for i in range(enemy_attack_pattern.get_child_count()):
		enemy_actions.push_back(enemy_attack_pattern.get_child(i).text)
		
		
	COMBATE.execute_enemy_actions.emit(enemy_actions)
	
	enemy_attack_pattern.Clear_All_Instructions()
	
	
	await get_tree().create_timer(1.0).timeout
	
	
	
	
	load_enemy_intentions(List_of_Enemies)
	
	
	turn_label.hide()
	
	
	COMBATE.finished_executing_enemy_actions.emit()
	
