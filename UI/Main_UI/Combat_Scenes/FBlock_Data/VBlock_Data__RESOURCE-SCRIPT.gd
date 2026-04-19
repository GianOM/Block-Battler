class_name VBlock_Data extends Resource

enum Block_Type{
	PLAYER,
	ENEMY,
	SUMMON
}




@export var id: String
@export var my_block_type: Block_Type
@export var attachment_sides: Array[String]

@export_multiline var tooltip: String


#func _init() -> void:
	##my_block_type = Block_Type.PLAYER
	#attachment_sides = ["LEFT"]
