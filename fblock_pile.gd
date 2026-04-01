#class_name FBlockPile
#extends Resource
#
#signal fblock_pile_size_changed(fblocks_amount)
#
#@export var fblocks: Array[Function_Block]
#
#func is_empty() -> bool:
	#return fblocks.is_empty()
#
#func add_fblock(block: Function_Block):
	#fblocks.push_back(block)
	#fblock_pile_size_changed.emit(fblocks.size())
#
#func clear():
	#fblocks.clear()
	#fblock_pile_size_changed.emit(fblocks.size())
	#
