extends FBlock_Data

var base_shield:= 5

func do_fblock_actions(target: Node):
	var shield:= Shield.new()
	shield.amount = base_shield
	shield.execute(target)
