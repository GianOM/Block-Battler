class_name EnemyStats
extends EntityStats

@export_category("Combat Related")
@export var action_scene: PackedScene



func load_actions():
	
	var test_pattern: Array[EnemyAction]
	var actions = action_scene.instantiate()
	
	
	
	for i in range(actions.get_child_count()):
		test_pattern.push_back(actions.get_child(i))
	return test_pattern
