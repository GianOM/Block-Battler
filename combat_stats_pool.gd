class_name CombatStatsPool
extends Resource

@export var pool: Array[CombatStats]

var total_weights_by_tier:= [0.0, 0.0, 0.0]

func _get_all_combats_for_tier(tier: CombatStats.Tier) -> Array[CombatStats]:
	return pool.filter(
		func(combat_stats: CombatStats):
			return combat_stats.tier == tier
	)

func _setup_weight_for_tier(tier: CombatStats.Tier):
	var combats:= _get_all_combats_for_tier(tier)
	total_weights_by_tier[tier] = 0.0
	for combat in combats:
		total_weights_by_tier[tier] += combat.weight
		combat.accumulated_weight = total_weights_by_tier[tier]

func get_random_combat_for_tier(tier: CombatStats.Tier):
	
	var roll:= randf_range(0.0, total_weights_by_tier[tier])
	var combats:= _get_all_combats_for_tier(tier)
	for combat in combats:
		if combat.accumulated_weight > roll:
			return combat
	return null

#WARNING need to test
#func setup():
	#for i in 3:
		#_setup_weight_for_tier(i)
func setup():
	var tiers = CombatStats.Tier.values()
	for i in tiers:
		_setup_weight_for_tier(i)
