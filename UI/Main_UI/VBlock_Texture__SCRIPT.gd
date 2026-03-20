extends TextureRect


const ENEMY_BLOCK = preload("uid://0aud66o3bf1u")
const ALLY_BLOCK = preload("uid://c5akcc2ltwatx")



func Set_Correct_Block_Texture(my_block_type: Variables_Block.Block_Type):
	match my_block_type:
		Variables_Block.Block_Type.ENEMY:
			texture = ENEMY_BLOCK
			
		Variables_Block.Block_Type.ALLY:
			texture = ALLY_BLOCK
