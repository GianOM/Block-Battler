class_name CombatManager
extends Node

@export var character_stats: CharacterStats: set = _set_character_stats

#@onready var enemy_attack_pattern: VBoxContainer = %EnemyAttackPattern

#@export var enemy_stats: EnemyStats: set = _set_enemy_stats

#func _set_enemy_stats(value: EnemyStats):
	#enemy_stats = value
	#enemy_attack_pattern.enemy_stats = enemy_stats

func _set_character_stats(value: CharacterStats):
	character_stats = value
	
	#TODO pass this character_stats value to whichever nodes
	#that might need it later
	#e.g. energy system UI, block inventory when they'll be 
	#drawn from code and based on the character stats
	#energy_ui.character_stats = character_stats
