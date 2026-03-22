extends Control

@onready var f_blocks_list: VBoxContainer = $HBoxContainer/Functions_Title/FBlocks_List
@onready var v_blocks_list: VBoxContainer = $HBoxContainer/Variables_Title/VBlocks_List


func _ready() -> void:
	COMBATE.finished_executing_player_actions.connect(Reset_All_Placed_Blocks)
	
	
	
	
	
func Reset_All_Placed_Blocks():
	
	for i in range(f_blocks_list.get_child_count()):
		var Temp_F_Block: Function_Block = f_blocks_list.get_child(i)
		
		Temp_F_Block.RESET()
		
	for j in range(v_blocks_list.get_child_count()):
		var Temp_V_Block: Variables_Block = v_blocks_list.get_child(j)
		
		Temp_V_Block.RESET()
		
		
	JOGADOR.current_Function_Attach_Block = null
	JOGADOR.current_Function_Dragging_Block = null
