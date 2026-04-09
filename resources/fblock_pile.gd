class_name FBlockPile
extends Resource



signal fblock_pile_size_changed(fblocks_amount)

@export var fblocks_Data: Array[FBlock_Data]

func is_empty() -> bool:
	return fblocks_Data.is_empty()

func size() -> int:
	return fblocks_Data.size()

func Get_Next_FBLock_Data() -> FBlock_Data:
	var fblock = fblocks_Data.pop_front()
	fblock_pile_size_changed.emit(fblocks_Data.size())
	return fblock

func add_fblock(block: FBlock_Data):
	fblocks_Data.push_back(block)
	fblock_pile_size_changed.emit(fblocks_Data.size())

func clear():
	fblocks_Data.clear()
	fblock_pile_size_changed.emit(fblocks_Data.size())
	
