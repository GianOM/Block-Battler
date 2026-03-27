extends Node2D

#This script is attached to the root of the combat tree
#it is the main one, where once combat starts, it will get
#the main stuff required for the battle, for now: player character
#enemies and distribute them to whichever nodes need it

@export var character_stats: CharacterStats
@onready var combat_ui: Control = $CombatUI
@onready var enemy_manager: EnemyManager = $EnemyManager
@onready var player_manager: PlayerManager = $PlayerManager
@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern


var Combat_Entities_ID: Dictionary = {}

func _ready() -> void:
	var new_stats:= character_stats.create_instance()
	player_manager.get_child(0).stats = new_stats 
	
	enemy_manager.child_order_changed.connect(_on_enemies_child_order_changed)
	COMBATE.player_died.connect(_on_player_died)
	COMBATE.player_turn_ended.connect(enemy_manager.start_turn)
	COMBATE.enemy_turn_ended.connect(player_manager.start_turn)
	
	start_combat(new_stats)
	

func start_combat(stats: CharacterStats):
	get_tree().paused = false
	setup_all_entities_ids()
	enemy_attack_pattern.enemy_manager_ref = enemy_manager
	player_manager.start_battle(stats)

func setup_all_entities_ids():
	for i in enemy_manager.get_child_count():
		var enemy_id_string: String = "E" + str(i+1)
		Combat_Entities_ID[enemy_id_string] = enemy_manager.get_child(i)
		enemy_manager.get_child(i).Set_Entity_ID(enemy_id_string)
	for i in player_manager.get_child_count():
		var player_id_string: String = "P" + str(i+1)
		Combat_Entities_ID[player_id_string] = player_manager.get_child(i)
		player_manager.get_child(i).Set_Entity_ID(player_id_string)
		
	COMBATE.Entities_ID_Loaded.emit(Combat_Entities_ID)
	COMBATE.Combat_ID_Dict = Combat_Entities_ID

#TODO to be tested
func _on_enemies_child_order_changed():
	if enemy_manager.get_child_count() == 0:
		COMBATE.end_of_combat_screen_requested.emit("ANY WINNERS???", EndOfCombatPanel.Type.WIN)

func _on_player_died():
	COMBATE.end_of_combat_screen_requested.emit("YOU SUCK", EndOfCombatPanel.Type.LOSE)
