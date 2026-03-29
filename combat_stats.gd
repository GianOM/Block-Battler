class_name CombatStats
extends Resource

enum Tier {NORMAL, ELITE, BOSS}

@export var tier: Tier
@export var tier_int: int
@export_range(0.0, 10.0) var weight: float
@export var min_gold: int
@export var max_gold: int
@export var enemies: PackedScene

var accumulated_weight:= 0.0

func roll_gold_reward() -> int:
	return randi_range(min_gold, max_gold)
