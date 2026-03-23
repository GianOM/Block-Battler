extends Node

@export var enemy: Enemy: set = _set_enemy
@export var target: Node2D: set = _set_target

#func _ready() -> void:
	#target = get_tree().get_first_node_in_group("player")
	#print(target)

func _set_enemy(value: Enemy):
	enemy = value
	for action in get_children():
		action.enemy = enemy

func _set_target(value: Node2D):
	target = value
	for action in get_children():
		action.target = target
		
		
		
func load_actions() -> Array[EnemyAction]:
	
	var Temp_Enemy_Action: Array[EnemyAction]
	
	
	for i in range(get_child_count()):
		
		var Node_Action: Node = get_child(i)
		
		Node_Action.Setup_Action(null, null, "E1 - ATT - P1")
		
		
		Temp_Enemy_Action.push_back(get_child(i))
		
		
		
	return Temp_Enemy_Action
		
		
		
		
