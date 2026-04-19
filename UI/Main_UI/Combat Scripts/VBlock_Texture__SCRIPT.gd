extends TextureRect


const ENEMY_BLOCK = preload("uid://0aud66o3bf1u")
const ALLY_BLOCK = preload("uid://c5akcc2ltwatx")



func Set_Correct_Block_Texture(my_block_data: VBlock_Data):
	match my_block_data.my_block_type:
		VBlock_Data.Block_Type.ENEMY:
			texture = ENEMY_BLOCK
			
		VBlock_Data.Block_Type.PLAYER:
			texture = ALLY_BLOCK
