extends Control

@export var character_stats: CharacterStats

#TODO for now the enemy resource will be set here
#later when encounters are randomized, idk yet
@export var enemy_stats: EnemyStats

@onready var combat_manager: CombatManager = $CombatManager
@onready var combat_2d: Node2D = $Combat2D
@onready var player = combat_2d.get_node("Player")

func _ready() -> void:
	#temp
	var new_stats = character_stats.create_instance()
	#player node
	player.stats = new_stats 
	#
	#var new_enemy = enemy_stats.create_instance()
	#combat_manager.enemy_stats = new_enemy
	
	start_combat(new_stats)

func start_combat(stats: CharacterStats):
	combat_manager.start_battle(stats)
	#enemy_attack_pattern.enemy_intention(turn_count, enemy_stats)
	
