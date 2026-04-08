class_name FBlock_Data extends Resource


enum Block_Type{
	ATTACK,
	DEFENSE,
	LOOP
}

@export var my_block_type: Block_Type
@export var attachment_sides: Array[String]


func My_Action():
	pass
