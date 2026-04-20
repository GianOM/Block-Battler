class_name CombatUI
extends Control

@onready var turn_ready_button: Button = %Turn_Ready_Button
@onready var list_of_player_instructions: VBoxContainer = %List_of_Player_Instructions
#@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern
@onready var turn_label: Label = %TurnLabel

func _ready() -> void:
	turn_ready_button.pressed.connect(_on_ready_pressed)
	COMBATE.player_action_stack.connect(start_player_action_stack)
	#COMBATE.enemy_action_stack.connect(start_enemy_action_stack)
	COMBATE.player_turn_ended.connect(_on_player_turn_ended)
	COMBATE.enemy_turn_ended.connect(_on_enemy_turn_ended)
	

func _on_player_turn_ended():
	turn_label.text = "Enemy Turn"

func _on_enemy_turn_ended():
	turn_ready_button.disabled = false
	turn_label.hide()

func _on_ready_pressed():
	turn_label.text = "Player Turn"
	turn_label.show()
	turn_ready_button.disabled = true
	COMBATE.execute_player_turn.emit()

func start_player_action_stack():
	var player_actions : Array[String]
	for i in range(list_of_player_instructions.get_child_count()):
		player_actions.push_back(list_of_player_instructions.get_child(i).text)
	COMBATE.execute_player_actions.emit(player_actions)
	for i in range(list_of_player_instructions.get_child_count()):
		list_of_player_instructions.get_child(i).queue_free()

#func start_enemy_action_stack():
	#enemy_attack_pattern.Clear_All_Instructions()
	#var enemy_actions: Array[String]
	#for i in range(enemy_attack_pattern.get_child_count()):
		#enemy_actions.push_back(enemy_attack_pattern.get_child(i).text)
	##print(enemy_actions)
	#COMBATE.execute_enemy_actions.emit(enemy_actions)
