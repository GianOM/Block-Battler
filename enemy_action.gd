class_name EnemyAction
extends Node

var self_id: String
var allies_target_id: Array[String]
var enemies_target_id: Array[String]



var action_description: String


@warning_ignore("unused_parameter")
func Setup_Action(ID_SELF: String, ID_ALLIED:Array[String], ID_Enemy: Array[String] ) -> void:
	pass
	
	
	
func perform_action():
	pass

func return_description():
	return action_description
	
