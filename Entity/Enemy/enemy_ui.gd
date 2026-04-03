@tool
class_name Enemy extends Node2D

@export var stats: EnemyStats: set = set_enemy_stats



@onready var variable_block: Variables_Block = $Variable_Block


@onready var entity_image: Sprite2D = $EntityImage
@onready var stats_ui: StatsUI = $StatsUI
@onready var intent_ui: IntentUI = $IntentUI

@onready var id_debug_text: Label = $"ID Debug Text"

@onready var status_manager: StatusManager = $StatusManager

@export var Enemy_Action_Scene: PackedScene

var Attack_Pattern_Node: Node


func _ready() -> void:
	#COMBATE.single_enemy_action.connect(execute_single_enemy_actions)
	Attack_Pattern_Node = Enemy_Action_Scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	add_child(Attack_Pattern_Node)
	
	
func set_enemy_stats(value: EnemyStats):
	
	
	if Engine.is_editor_hint():
		stats = value.duplicate(true)
		entity_image.texture = stats.image
	else :
		
		stats = value.create_instance()
	
		if not stats.changes_in_stats.is_connected(update_stats):
			stats.changes_in_stats.connect(update_stats)
			#stats.changes_in_stats.connect(update_action)
		
		
		update_enemy()

#func single_enemy_turn():
	###remove o shield no começo de cada turno
	#stats.shield = 0
	##COMBATE.request_enemy_action.emit(self, COMBATE.turn_count)
	##COMBATE.enemy_action_stack.emit()

func do_enemy_turn():
	stats.shield = 0
	var enemy_actions: Array[EnemyAction] = Attack_Pattern_Node.load_actions()
	var counter = COMBATE.turn_count - 1
	if counter >= enemy_actions.size():
		counter %= enemy_actions.size()
	for i in enemy_actions.size():
		if i == counter:
			enemy_actions[i].perform_action()

##test
#func execute_single_enemy_actions(action: String):
	#var action_parameters: PackedStringArray = action.split("-", false)
	#var Temp_Node
	#var attacking_enemy = COMBATE.Combat_ID_Dict[action_parameters[0]]
	#if not attacking_enemy:
		#return
	#for j in attacking_enemy.Attack_Pattern_Node.get_child_count():
		#var action_node_name = attacking_enemy.Attack_Pattern_Node.get_child(j).name
		#if action.contains(action_node_name):
			##print(action_node_name)
			#Temp_Node = attacking_enemy.Attack_Pattern_Node.get_child(j)
#
		#
	#var target = COMBATE.Combat_ID_Dict[action_parameters[-1]]
	#if not target:
		#return
	#Temp_Node.perform_action()
	

func set_intent_ui(value: EnemyAction):
	var action = value
	if action:
		#TODO glorp actions have no intent
		intent_ui.update_intent(action.intent, value, stats.strength)
		#print(action.intent)
	
#func update_action():
	#pass

func update_stats():
	stats_ui.update_stats(stats)
	
func update_enemy():
	if not stats is EnemyStats:
		return
	if not is_inside_tree():
		await ready
		
	entity_image.texture = stats.image
	update_stats()

func take_damage(damage: int):
	if stats.hp <= 0:
		return
	var tween:= create_tween()
	tween.tween_callback(COMBATE.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.2)
	tween.finished.connect(
		func():
			if stats.hp <= 0:
				COMBATE.enemy_died.emit(self)
				queue_free()
	)
	
func Set_Entity_ID(input_text: String):
	
	id_debug_text.text = input_text
	id_debug_text.show()
	
	
	Attack_Pattern_Node.Set_Self_ID(input_text)
	variable_block.Set_Block_ID(input_text)
	
	
