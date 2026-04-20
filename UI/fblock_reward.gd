class_name FBlockReward
extends ColorRect

signal fblock_reward_selected(fblock: FBlock_Data)

const FBLOCK_SIMPLIFIED_UI = preload("res://UI/fblock_simplified_ui.tscn")

@export var rewards: Array[FBlock_Data]: set = set_rewards

@onready var f_blocks: HBoxContainer = %FBlocks
@onready var skip_button: Button = %SkipButton

func _ready() -> void:
	_clear_rewards()
	
	skip_button.pressed.connect(
		func():
			fblock_reward_selected.emit(null)
			queue_free()
	)

func _clear_rewards():
	for fblock in f_blocks.get_children():
		fblock.queue_free()
	
func set_rewards(new_fblocks: Array[FBlock_Data]):
	rewards = new_fblocks
	
	if not is_node_ready():
		await ready
	_clear_rewards()
	for fblock: FBlock_Data in rewards:
		var new_fblock:= FBLOCK_SIMPLIFIED_UI.instantiate()
		new_fblock.fblock = fblock
		new_fblock.pressed.connect(
			func():
				fblock_reward_selected.emit(new_fblock.fblock)
				queue_free()
		)
		f_blocks.add_child(new_fblock)
		
	
