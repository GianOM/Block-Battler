class_name FBlock_Data extends Resource


enum Block_Type{
	ATTACK,
	DEFENSE,
	LOOP
}

@export var id: String
@export var my_block_type: Block_Type
@export var attachment_sides: Array[String]

@export_multiline var tooltip: String

func play(target: Node):
	COMBATE.fblock_played.emit(self)
	do_fblock_actions(target)

func do_fblock_actions(_target: Node):
	pass
