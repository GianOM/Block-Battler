class_name Enemy
extends Node2D

@export var stats: EnemyStats: set = set_enemy_stats

@onready var entity_image: Sprite2D = $EntityImage
@onready var stats_ui: StatsUI = $StatsUI
@onready var intent_ui: IntentUI = $IntentUI

@onready var id_debug_text: Label = $"ID Debug Text"

@export var Enemy_Action_Scene: PackedScene

var Attack_Pattern_Node: Node


func _ready() -> void:
	
	Attack_Pattern_Node = Enemy_Action_Scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	add_child(Attack_Pattern_Node)
	
	
func set_enemy_stats(value: EnemyStats):
	stats = value.create_instance()
	if not stats.changes_in_stats.is_connected(update_stats):
		stats.changes_in_stats.connect(update_stats)
		#stats.changes_in_stats.connect(update_action)
	update_enemy()

func single_enemy_turn():
	print("tira shield")
	stats.shield = 0
	if self.name == "Enemy2":
		print("breakpoint")
	COMBATE.enemy_action_stack.emit()

func set_intent_ui(value: EnemyAction):
	var action = value
	if action:
		intent_ui.update_intent(action.intent)
	
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
				queue_free()
	)

func give_shield(value: int):
	stats.shield += clampi(value, 0, 999)
	update_stats()
	
	
	
func Set_Entity_ID(input_text: String):
	
	id_debug_text.text = input_text
	id_debug_text.show()
	
	
	Attack_Pattern_Node.Set_Self_ID(input_text)
	
	
	
	
