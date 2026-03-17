extends TextureRect

const ATTACK_BLOCK_TEXTURE = preload("uid://mvby122lvlaf")
const DEFENSE_BLOCK_TEXTURE = preload("uid://b47kaoki5qc1")
const LOOP_BLOCK_TEXTURE = preload("uid://d0mj3j6idd4x5")

func Set_Correct_Block_Texture(my_block_type: Function_Block.Block_Type):
	match my_block_type:
		Function_Block.Block_Type.ATTACK:
			
			texture = ATTACK_BLOCK_TEXTURE
			
		Function_Block.Block_Type.DEFENSE:
			
			texture = DEFENSE_BLOCK_TEXTURE
			
		Function_Block.Block_Type.LOOP:
			
			texture = LOOP_BLOCK_TEXTURE
