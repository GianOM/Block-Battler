class_name EnemyAction
extends Node

var enemy: Enemy
var target: Node2D
var description: String


func Setup_Action(action_enemy: Enemy, action_target: Node2D, action_description: String) -> void:
	enemy = action_enemy
	target = action_target
	description = action_description
	
	
	
func perform_action():
	pass

func return_description():
	return description
	
