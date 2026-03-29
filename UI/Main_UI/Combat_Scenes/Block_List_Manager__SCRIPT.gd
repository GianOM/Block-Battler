extends Control

@onready var f_blocks_list: VBoxContainer = $HBoxContainer/Functions_Title/FBlocks_List
@onready var v_blocks_list: VBoxContainer = $HBoxContainer/Variables_Title/VBlocks_List

var Block_List_Instance: Node

func _ready() -> void:
	COMBATE.execute_player_turn.connect(Reset_All_Placed_Blocks)
	COMBATE.Load_Player_FBlocks.connect(Setup_all_FBlocks)
		
		
		
		
func Setup_all_FBlocks(Block_Lists_Scene: PackedScene):
	
	Block_List_Instance = Block_Lists_Scene.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	add_child(Block_List_Instance)
	
	
	for fblock in Block_List_Instance.get_children():
		fblock.reparent(f_blocks_list,false)
	
	
	
func Reset_All_Placed_Blocks():
	
	for i in range(f_blocks_list.get_child_count()):
		var Temp_F_Block: Function_Block = f_blocks_list.get_child(i)
		
		Temp_F_Block.RESET()
		
		
	JOGADOR.current_Function_Attach_Block = null
	JOGADOR.current_Function_Dragging_Block = null
