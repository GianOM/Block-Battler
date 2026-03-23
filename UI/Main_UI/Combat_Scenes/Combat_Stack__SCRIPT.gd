extends Control



@onready var list_of_player_instructions: VBoxContainer = $Player_Stack_Panel/ScrollContainer/List_of_Player_Instructions


func _ready() -> void:
	
	JOGADOR.Player_Connected_Blocks.connect(_on_block_connection_formed)
	
	
func _on_block_connection_formed(Connected_Blocks_Root: Universal_Block):
	
	var Instruction_String: String = "P1-"
	
	
	match Connected_Blocks_Root.my_block_type:
		
		Function_Block.Block_Type.ATTACK:
			Instruction_String += "ATT-"
			
		Function_Block.Block_Type.DEFENSE:
			Instruction_String += "DEF-"
	
	
	for child_block in Connected_Blocks_Root.Child_Blocks:
		
		Instruction_String += child_block.Block_Target
		
		
		
		
	list_of_player_instructions.Make_Command_from_Instructions(Instruction_String)
	
