class_name PlayerManager
extends Node2D

@export var player: Player

@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern
@onready var list_of_player_instructions: VBoxContainer = %List_of_Player_Instructions
#@onready var turn_ready_button: Button = $"../Turn_Ready_Button"
#@onready var turn_label: Label = $"../TurnLabel"

var character: CharacterStats
var List_of_Enemies: Array[Enemy]


func _ready() -> void:
	COMBATE.execute_player_turn.connect(execute_player_turn)
	COMBATE.execute_player_actions.connect(execute_player_actions)


func start_battle(character_stats: CharacterStats):
	COMBATE.turn_count = 0
	character = character_stats
	player.status_manager.statuses_applied.connect(_on_statuses_applied)
	#TBD anything else that needs to happen at the start of combat
	#e.g. duplicating the block pools if necessary etc
	start_turn()

func start_turn():
	character.shield = 0
	player.status_manager.apply_statuses_by_type(Status.Type.START_OF_TURN)
	COMBATE.load_enemy_intentions_requested.emit()
	#turn_ready_button.show() #move to ui
	
	#TBD reset energy or whatever

#on ready button pressed AKA end player turn
func execute_player_turn():
	player.status_manager.apply_statuses_by_type(Status.Type.END_OF_TURN)
	COMBATE.turn_count += 1
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
			
			#for debugging, applies vulnerable to the enemy hit
			#only visually for now, actual effects TODO
			var status_effect:= StatusEffect.new()
			var vulnerable_res:= preload("res://statuses/vulnerable.tres")
			var vulnerable := vulnerable_res.duplicate()
			vulnerable.duration = 2
			status_effect.status = vulnerable
			status_effect.execute(target_enemy)

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

func _on_statuses_applied(type: Status.Type):
	match type:
		Status.Type.START_OF_TURN:
			#draw fblocks and stuff
			pass
		Status.Type.END_OF_TURN:
			#discard stuff
			pass
