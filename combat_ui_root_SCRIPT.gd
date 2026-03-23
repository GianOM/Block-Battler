extends Control

#This script is attached to the root of the combat tree
#it is the main one, where once combat starts, it will get
#the main stuff required for the battle, for now: player character
#enemies and distribute them to whichever nodes need it

@export var character_stats: CharacterStats

@onready var combat_manager: CombatManager = $CombatManager
@onready var combat_2d: Node2D = $Combat2D
@onready var player: Player = combat_2d.get_node("Player")
@onready var enemy_manager: EnemyManager = combat_2d.get_node("EnemyManager")

func _ready() -> void:
	var new_stats:= character_stats.create_instance()
	player.stats = new_stats 
	
	enemy_manager.child_order_changed.connect(_on_enemies_child_order_changed)
	COMBATE.player_died.connect(_on_player_died)
	
	COMBATE.finished_executing_enemy_actions.connect(combat_manager.start_turn)
	#TODO connect signals related to player e.g. player start/end turn
	#and related to enemy e.g. enemy start/end turn etc
	
	start_combat(new_stats)

func start_combat(stats: CharacterStats):
	combat_manager.start_battle(stats)
	#enemy_attack_pattern.enemy_intention(turn_count, enemy_stats)

#TODO to be tested, need to fix enemy var block IDs
func _on_enemies_child_order_changed():
	if enemy_manager.get_child_count() == 0:
		print("all enemies dead AKA you win")

func _on_player_died():
	print("player deadge AKA you suck")
