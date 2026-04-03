class_name Player
extends Node2D

@export var stats: CharacterStats: set = set_character_stats

@onready var variable_block: Variables_Block = $Variable_Block


@onready var player_image: Sprite2D = $PlayerImage
@onready var stats_ui: StatsUI = $StatsUI
@onready var status_manager: StatusManager = $StatusManager

@onready var id_debug_text: Label = $"ID Debug Text"


var Player_Block_Lists: Node

func set_character_stats(value: CharacterStats):
	stats = value
	if not stats.changes_in_stats.is_connected(update_stats):
		stats.changes_in_stats.connect(update_stats)
		
		
		
	Player_Block_Lists = stats.my_block_list.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	add_child(Player_Block_Lists)
	
	Player_Block_Lists.hide()
	
	COMBATE.Load_Player_FBlocks.emit(Player_Block_Lists.duplicate(Node.DuplicateFlags.DUPLICATE_DEFAULT))
	
	update_player()

func update_player():
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
	player_image.texture = stats.image
	update_stats()

func update_stats():
	stats_ui.update_stats(stats)

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
				COMBATE.player_died.emit()
				queue_free()
	)
	
func Set_Entity_ID(input_text: String):
	
	id_debug_text.text = input_text
	id_debug_text.show()
	
	
	#Attack_Pattern_Node.Set_Self_ID(input_text)
	variable_block.Set_Block_ID(input_text)
	
	
	
