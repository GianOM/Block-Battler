extends Control



@onready var list_of_player_instructions: VBoxContainer = $Player_Stack_Panel/ScrollContainer/List_of_Player_Instructions


func _ready() -> void:
	
	JOGADOR.Player_Connected_Blocks.connect(_on_block_connection_formed)
	JOGADOR.Player_Disconnected_Blocks.connect(_on_block_connection_broken)
	
	
func _on_block_connection_formed(Connected_Blocks_Root: Universal_Block):
	
	COMBATE.list_of_fblocks_played.push_back(Connected_Blocks_Root.My_Block_Data)
	
	var Instruction_String: String = Connected_Blocks_Root.My_Block_Data.id + "-" + "P1-"
	
	Instruction_String += str(Connected_Blocks_Root.variable_number) + "-"
	
	#Connected_Blocks_Root.My_Block_Data.My_Action()
	
	
	#match Connected_Blocks_Root.My_Block_Data.my_block_type:
		#
		#FBlock_Data.Block_Type.ATTACK:
			#Instruction_String += "ATT-" + str(Connected_Blocks_Root.variable_number) + "-"
			#
			#
		#FBlock_Data.Block_Type.DEFENSE:
			#Instruction_String += "DEF-" + str(Connected_Blocks_Root.variable_number) + "-"
	
	
	for child_block in Connected_Blocks_Root.Child_Blocks:
		
		Instruction_String += child_block.Block_Target
		
		
		
		
	list_of_player_instructions.Make_Command_from_Instructions(Instruction_String)
	
	
	
func _on_block_connection_broken(Connected_Blocks_Root: Universal_Block):
	
	for Block_Played in COMBATE.list_of_fblocks_played:
		if Connected_Blocks_Root.My_Block_Data.id == Block_Played.id:
			COMBATE.list_of_fblocks_played.erase(Block_Played)
	
	var Block_Instance_ID: int = Connected_Blocks_Root.get_instance_id()
	
	list_of_player_instructions.Erase_Command_from_ID(Block_Instance_ID)
	
	
	
	
	
	
	
	
	
	
