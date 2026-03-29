extends Control

@onready var f_blocks_list: VBoxContainer = $HBoxContainer/Functions_Title/FBlocks_List
@onready var v_blocks_list: VBoxContainer = $HBoxContainer/Variables_Title/VBlocks_List

var Block_List_Instance: Node

func _ready() -> void:
	COMBATE.execute_player_turn.connect(Reset_All_Placed_Blocks)
	COMBATE.Load_Player_FBlocks.connect(Setup_all_FBlocks)
		
		
		
		
func Setup_all_FBlocks(Block_Lists_Root: Node):
	
	Block_Lists_Root.show()
	
	for fblock in Block_Lists_Root.get_children():
		fblock.reparent(f_blocks_list, false)
		
	await get_tree().create_timer(0.5).timeout
	
	Block_Lists_Root.queue_free()
	
	
	
func Reset_All_Placed_Blocks():
	
	for i in range(f_blocks_list.get_child_count()):
		var Temp_F_Block: Function_Block = f_blocks_list.get_child(i)
		
		Temp_F_Block.RESET()
		
		
	JOGADOR.current_Function_Attach_Block = null
	JOGADOR.current_Function_Dragging_Block = null
