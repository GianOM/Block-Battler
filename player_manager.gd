class_name PlayerManager
extends Node2D

@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern
@onready var list_of_player_instructions: VBoxContainer = %List_of_Player_Instructions
#@onready var turn_ready_button: Button = $"../Turn_Ready_Button"
#@onready var turn_label: Label = $"../TurnLabel"

var character: CharacterStats
var List_of_Enemies: Array[Enemy]
var turn_count := 0


func _ready() -> void:
	COMBATE.execute_player_turn.connect(execute_player_turn)
	COMBATE.execute_player_actions.connect(execute_player_actions)


func start_battle(character_stats: CharacterStats):
	character = character_stats
	#TBD anything else that needs to happen at the start of combat
	#e.g. duplicating the block pools if necessary etc
	start_turn()

func start_turn():
	COMBATE.load_enemy_intentions_requested.emit(turn_count)
	#turn_ready_button.show() #move to ui
	character.shield = 0
	#TBD reset energy or whatever

func execute_player_turn():
	turn_count += 1
	COMBATE.player_action_stack.emit()
	

func execute_player_actions(actions: Array[String]):
	for i in actions:
		var action_parameters: PackedStringArray = i.split("-", false)
		if i.contains("ATT"):
			# EXEMPLO: P1-ATT-15-E2
			var target_enemy = COMBATE.Combat_ID_Dict[action_parameters[-1]]
			if not target_enemy:
				continue
			var damage = Damage.new()
			damage.amount = action_parameters[-2]
			damage.execute(target_enemy)

		elif i.contains("DEF"):
			var target_player: Player = COMBATE.Combat_ID_Dict[action_parameters[-1]]
			if not target_player:
				continue
			var shield = Shield.new()
			shield.amount = action_parameters[-2]
			shield.execute(target_player)
			
			
			
	#Evitar que o turno do Player acabe antes de dar o dano
	await get_tree().create_timer(1.0).timeout
	
	
	
	COMBATE.player_turn_ended.emit()
