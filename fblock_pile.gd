class_name FBlockPile
extends Resource



signal fblock_pile_size_changed(fblocks_amount)

@export var fblocks_Data: Array[FBlock_Data]
#
func is_empty() -> bool:
	return fblocks_Data.is_empty()
	
	
	
func Get_Next_FBLock_Data() -> FBlock_Data:
	return fblocks_Data.pop_front()
	#TODO: Good luck killer
#
#func add_fblock(block: Function_Block):
	#fblocks.push_back(block)
	#fblock_pile_size_changed.emit(fblocks.size())
#
#func clear():
	#fblocks.clear()
	#fblock_pile_size_changed.emit(fblocks.size())
	#
