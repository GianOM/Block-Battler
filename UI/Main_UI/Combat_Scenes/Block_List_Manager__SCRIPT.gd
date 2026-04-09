class_name BlockList
extends Control

@onready var f_blocks_list: VBoxContainer = $HBoxContainer/Functions_Title/FBlocks_List
@onready var v_blocks_list: VBoxContainer = $HBoxContainer/Variables_Title/VBlocks_List

var Block_List_Instance: Node

@export var character_stats: CharacterStats
#@export var fblock_pile: FBlockPile


const FUNCTION_BLOCK__SCENE = preload("uid://bwed0118amt63")

func _ready() -> void:
	COMBATE.execute_player_turn.connect(Reset_All_Placed_Blocks)
	await get_tree().create_timer(0.1).timeout
	#Setup_all_FBlocks(character_stats.)
	#COMBATE.Load_Player_FBlocks.connect(Setup_all_FBlocks)
		
func add_fblock(fblock: FBlock_Data):
	var new_fblock_ui:= FUNCTION_BLOCK__SCENE.instantiate()
	f_blocks_list.add_child(new_fblock_ui)
	new_fblock_ui.My_Block_Data = fblock



#func Setup_all_FBlocks(FBlock_Player_Pile: FBlockPile):
	#
	#
	#while not FBlock_Player_Pile.is_empty():
		#var Temp_FBLock_Data: FBlock_Data = FBlock_Player_Pile.Get_Next_FBLock_Data()
		#
		#var Temp_FBlock: Function_Block = FUNCTION_BLOCK__SCENE.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
		#
		#Temp_FBlock.My_Block_Data = Temp_FBLock_Data
		#f_blocks_list.add_child(Temp_FBlock)
		
		
	
	#Block_Lists_Root.show()
	#
	#for fblock in Block_Lists_Root.get_children():
		#fblock.reparent(f_blocks_list, false)
		#
	#await get_tree().create_timer(0.5).timeout
	#
	#Block_Lists_Root.queue_free()
	
	
	
func Reset_All_Placed_Blocks():
	
	for i in range(f_blocks_list.get_child_count()):
		var Temp_F_Block: Function_Block = f_blocks_list.get_child(i)
		
		Temp_F_Block.RESET()
		
		
	JOGADOR.current_Function_Attach_Block = null
	JOGADOR.current_Function_Dragging_Block = null
